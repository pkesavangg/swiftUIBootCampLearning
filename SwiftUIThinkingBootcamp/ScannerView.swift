//
//  ScannerView.swift
//  SwiftUIThinkingBootcamp
//
//  Created by Kesavan Panchabakesan on 29/11/23.
//
import Foundation
import SwiftUI
import Vision
import VisionKit


struct MainView: View {
    @State public var recognizedText = "No Scanned Text"
    @State private var showScannerView = false
    @State private var showImagePickerView = false
    var body: some View {
        NavigationView{
            VStack {
                List {
                    Section(header: HStack{ Text("Selected Text:") }) {
                        NavigationLink("Scanned Text") {
                            ScrollView {
                                Text(recognizedText)
                            }
                        }
                    }
                    Section(footer: VStack(alignment: .center, spacing: 20) {
                        HStack {
                            
                            Button {
                                showImagePickerView = true
                            } label: {
                                Text("Choose from photos")
                                    .padding(.all, 5)
                                    .padding(.horizontal, 5)
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(5)
                            }
                            Button {
                                showScannerView = true
                            } label: {
                                Text("Scan Pictures")
                                    .padding(.all, 5)
                                    .padding(.horizontal, 5)
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(5)
                            }
                        }
                    }) {
                        EmptyView()
                    }
                }
            }
        }
        .sheet(isPresented: $showScannerView, content: {
            self.makeScannerView()
        })
        .sheet(isPresented: $showImagePickerView, content: {
            ImagePickerView(recognizedText: $recognizedText)
        })
    }
    
    private func makeScannerView()-> ScannerView {
        ScannerView(completion: {
            textPerPage in
            if let outputText = textPerPage?.joined(separator: "\n").trimmingCharacters(in: .whitespacesAndNewlines){
                self.recognizedText = outputText
            }
            self.showScannerView = false
        })
    }
}


struct ScannerView: UIViewControllerRepresentable {
    private let completionHandler: ([String]?) -> Void
     
    init(completion: @escaping ([String]?) -> Void) {
        self.completionHandler = completion
    }
     
    typealias UIViewControllerType = VNDocumentCameraViewController
     
    func makeUIViewController(context: UIViewControllerRepresentableContext<ScannerView>) -> VNDocumentCameraViewController {
        let viewController = VNDocumentCameraViewController()
        viewController.delegate = context.coordinator
        return viewController
    }
     
    func updateUIViewController(_ uiViewController: VNDocumentCameraViewController, context: UIViewControllerRepresentableContext<ScannerView>) {}
     
    func makeCoordinator() -> Coordinator {
        return Coordinator(completion: completionHandler)
    }
     
    final class Coordinator: NSObject, VNDocumentCameraViewControllerDelegate {
        private let completionHandler: ([String]?) -> Void
         
        init(completion: @escaping ([String]?) -> Void) {
            self.completionHandler = completion
        }
         
        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
            let recognizer = TextRecognizer(cameraScan: scan)
            recognizer.recognizeText(withCompletionHandler: completionHandler)
        }
         
        func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
            completionHandler(nil)
        }
         
        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: Error) {
            completionHandler(nil)
        }
    }
}

final class TextRecognizer {
    let cameraScan: VNDocumentCameraScan
    init(cameraScan:VNDocumentCameraScan) {
        self.cameraScan = cameraScan
    }
    private let queue = DispatchQueue(label: "Scanning",qos: .default,attributes: [],autoreleaseFrequency: .workItem)
    func recognizeText(withCompletionHandler completionHandler:@escaping ([String])-> Void) {
        queue.async {
            let images = (0..<self.cameraScan.pageCount).compactMap({
                self.cameraScan.imageOfPage(at: $0).cgImage
            })
            let imagesAndRequests = images.map({(image: $0, request:VNRecognizeTextRequest())})
            let textPerPage = imagesAndRequests.map{image,request->String in
                let handler = VNImageRequestHandler(cgImage: image, options: [:])
                do{
                    try handler.perform([request])
                    guard let observations = request.results else{return ""}
                    return observations.compactMap({$0.topCandidates(1).first?.string}).joined(separator: "\n")
                }
                catch{
                    print(error)
                    return ""
                }
            }
            DispatchQueue.main.async {
                completionHandler(textPerPage)
            }
        }
    }
}

struct ImagePickerView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding public var recognizedText: String
    @State private var image: UIImage?
    var body: some View {
        VStack {
            ImagePicker(image: $image)
                .frame(maxWidth: .infinity)
                .padding()
            Button {
                recognizeText()
            } label: {
                Text("Recognize Text")
                    .padding(.all, 5)
                    .padding(.horizontal, 5)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(5)
            }
        }
    }

    func recognizeText() {
        guard let image = image else { return }

        let request = VNRecognizeTextRequest { request, error in
            if error != nil {
                return
            }

            guard let observations = request.results as? [VNRecognizedTextObservation] else { return }

            let recognizedText = observations.compactMap { observation in
                observation.topCandidates(1).first?.string
            }.joined(separator: "\n")
            self.recognizedText = recognizedText
        }

        let handler = VNImageRequestHandler(cgImage: image.cgImage!, options: [:])

        do {
            try handler.perform([request])
        } catch {
        }
        presentationMode.wrappedValue.dismiss()
    }
}


struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @State private var isImagePickerPresented: Bool = false

    func makeUIViewController(context: Context) -> UIViewController {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = context.coordinator
        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }

            parent.isImagePickerPresented = false
        }
    }
}


#Preview {
    MainView()
}












//struct ScanData: Identifiable {
//    var id = UUID()
//    let content: String
//    
//}

//struct ImageToTextView: View {
//    @State private var showScannerSheet = false
//        @State private var texts:[String] = []
//        var body: some View {
//            NavigationView{
//                VStack{
//                    if texts.count > 0{
//                        List{
//                            ForEach(texts, id: \.self){text in
//                                NavigationLink(
//                                    destination:ScrollView{Text(text)},
//                                    label: {
//                                        Text(text).lineLimit(1)
//                                    })
//                            }
//                        }
//                    }
//                    else{
//                        Text("No scanned text")
//                            .font(.title)
//                    }
//                }
//                    .navigationTitle("Scan Text")
//                    .navigationBarItems(trailing: Button(action: {
//                        self.showScannerSheet = true
//                    }, label: {
//                        Image(systemName: "doc.text.viewfinder")
//                            .font(.title)
//                    })
//                    .sheet(isPresented: $showScannerSheet, content: {
//                        self.makeScannerView()
//                    })
//                    )
//            }
//        }
//        private func makeScannerView()-> ScannerView {
//            ScannerView(completion: {
//                textPerPage in
//                if let outputText = textPerPage?.joined(separator: "\n").trimmingCharacters(in: .whitespacesAndNewlines){
//                    self.texts.append(outputText)
//                }
//                self.showScannerSheet = false
//            })
//        }
//}
