//
//  PDFToTextView.swift
//  SwiftUIThinkingBootcamp
//
//  Created by Kesavan Panchabakesan on 12/12/23.
//

import SwiftUI
import PDFKit
import Foundation
import Vision

extension PDFPage {
    func convertToImage() -> UIImage? {
        let pageSize = bounds(for: .mediaBox).size
        let renderer = UIGraphicsImageRenderer(size: pageSize)
        
        let image = renderer.image { context in
            UIColor.white.set()
            context.fill(bounds(for: .mediaBox))
            
            context.cgContext.translateBy(x: 0, y: pageSize.height)
            context.cgContext.scaleBy(x: 1, y: -1)
            
            self.draw(with: .mediaBox, to: context.cgContext)
        }
        return image
    }
}

struct PDFToTextView: View {
    @State private var presentImporter = false
    @State private var selectedFile: URL?
    @State private var pdfDocument: PDFDocument?
    @State var originalImage = UIImage(named: "google-icon")!
    // Add these properties for cropping
    @State private var cropRect: CGRect? = CGRect(x: 0, y: 0, width: 500, height: 500)
    @State private var selectedTexts: [String] = []
    @State public var resultedImages: [UIImage?] = []
    var body: some View {
        NavigationView {
            VStack(content: {
                HStack {
                    Spacer()
                    Button(action: {
                        presentImporter = true
                        selectedFile = nil
                        selectedTexts = []
                        resultedImages = []
                    }, label: {
                        Text("Open PDF")
                            .foregroundColor(.white)
                            .font(.title2)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 30)
                            .background(Color.blue)
                            .cornerRadius(10)
                    })
                    Spacer()
                    Button(action: {
                        presentImporter = false
                        selectedFile = nil
                    }, label: {
                        Text("Close")
                            .foregroundColor(.white)
                            .font(.title2)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 30)
                            .background(Color.blue)
                            .cornerRadius(10)
                    })
                    Spacer()
                }
                .fileImporter(isPresented: $presentImporter, allowedContentTypes: [.pdf]) { result in
                    switch result {
                    case .success(let url):
                        url.startAccessingSecurityScopedResource()
                        loadPDF(from: url)
                        selectedFile = url
                    case .failure(let error):
                        print(error)
                    }
                }
                .toolbar(content: {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink("View Selected Texts") {
                            
                            List {
                                ForEach(selectedTexts, id: \.self) { value in
                                    Text(value)
                                    
                                }
                            }
                        }
                        .disabled(selectedTexts.count <= 0)
                    }
                })
                
                Spacer()
                if resultedImages.count > 0 {
                    // self.recognizeText(image: image)
                    ImageScrollView(pdfImages: resultedImages, selectedTexts: $selectedTexts)
                }
                //                else {
                //                        if let selectedFile = selectedFile {
                //                            PDFKitRepresentedView(pdfDocument: pdfDocument ?? nil)
                //                                .onDisappear(perform: {
                //                                    selectedFile.stopAccessingSecurityScopedResource()
                //                                })
                //                        }
                //                    }
                
            })
            .navigationTitle("PDF OCR")
        }
    }
    
    private func convertPDFToImages(pdfDocument: PDFDocument) {
        var images: [UIImage] = []
        for i in 0..<pdfDocument.pageCount {
            if let pdfPage = pdfDocument.page(at: i) {
                if let image = pdfPage.convertToImage() {
                    images.append(image)
                }
            }
        }
        resultedImages = images // Display the first image (you can handle this as per your requirements)
    }
    
    
    private func loadPDF(from url: URL) {
        do {
            let data = try Data(contentsOf: url)
            pdfDocument = PDFDocument(data: data)
            
            if let pdfDocument = pdfDocument {
                convertPDFToImages(pdfDocument: pdfDocument)
            }
            
        } catch {
            print("Error loading PDF: \(error)")
        }
    }
    
}


struct PDFKitRepresentedView: UIViewRepresentable {
    var pdfDocument: PDFDocument?
    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.autoScales = true
        return pdfView
    }
    func updateUIView(_ uiView: PDFView, context: Context) {
        uiView.document = pdfDocument
    }
}





struct ImageScrollView: View {
    @State public var pdfImages: [UIImage?]
    @State private var currentIndex: Int = 0
    @Binding public var selectedTexts: [String]
    var body: some View {
        VStack {
            HStack {
                Spacer()
                ImageCropView(image: $pdfImages[self.currentIndex]) { text in
                    if let value = text {
                        selectedTexts.append(value)
                    } else {
                    }
                }
                Spacer()
            }
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    HStack {
                        Button(action: {
                            withAnimation {
                                self.currentIndex = max(self.currentIndex - 1, 0)
                            }
                        }) {
                            Text("<- Previous")
                        }
                        .disabled(currentIndex == 0)
                        
                        Spacer()
                        
                        Button(action: {
                            withAnimation {
                                self.currentIndex = min(self.currentIndex + 1, pdfImages.count - 1)
                            }
                        }) {
                            Text("Next Image ->")
                        }
                        .disabled(currentIndex == pdfImages.count - 1)
                    }
                }
            }
        }
    }
}

struct ImageCropView: View {
    @Environment(\.presentationMode) var pm
    @State var imageWidth:CGFloat = 0
    @State var imageHeight:CGFloat = 0
    @Binding var image : UIImage?
    @State var selectedText: String?
    @State var dotSize:CGFloat = 13
    var dotColor = Color.init(white: 1).opacity(0.9)
    
    @State var center:CGFloat = 0
    @State var activeOffset:CGSize = CGSize(width: 0, height: 0)
    @State var finalOffset:CGSize = CGSize(width: 0, height: 0)
    
    @State var rectActiveOffset:CGSize = CGSize(width: 0, height: 0)
    @State var rectFinalOffset:CGSize = CGSize(width: 0, height: 0)
    
    @State var activeRectSize : CGSize = CGSize(width: 200, height: 100)
    @State var finalRectSize : CGSize = CGSize(width: 200, height: 100)
    public let completionHandler: (String?) -> Void
    var body: some View {
        
        ZStack {
            Image(uiImage: image ?? UIImage())
                .resizable()
                .scaledToFit()
                .overlay(GeometryReader{geo -> AnyView in
                    DispatchQueue.main.async{
                        self.imageWidth = geo.size.width
                        self.imageHeight = geo.size.height
                    }
                    return AnyView(EmptyView())
                })
            
            
            Button(action: {
                let cgImage: CGImage = (image?.cgImage!)!
                let scaler = CGFloat(cgImage.width)/imageWidth
                if let cImage = cgImage.cropping(to: CGRect(x: getCropStartCord().x * scaler, y: getCropStartCord().y * scaler, width: activeRectSize.width * scaler, height: activeRectSize.height * scaler)){
                    recognizeText(image: UIImage(cgImage: cImage))
                }
                pm.wrappedValue.dismiss()
            }, label: {
                Text("Recognize Text")
                    .padding()
                    .foregroundColor(.white)
                    .background(Capsule().fill(Color.blue))
                
            })
            .offset(y: 200)
            
            Rectangle()
                .stroke(lineWidth: 1)
                .foregroundColor(.white)
                .offset(x: rectActiveOffset.width, y: rectActiveOffset.height)
                .frame(width: activeRectSize.width, height: activeRectSize.height)
            
            Rectangle()
                .stroke(lineWidth: 1)
                .foregroundColor(.white)
                .background(Color.green.opacity(0.3))
                .offset(x: rectActiveOffset.width, y: rectActiveOffset.height)
                .frame(width: activeRectSize.width, height: activeRectSize.height)
                .gesture(
                    DragGesture()
                        .onChanged{drag in
                            let workingOffset = CGSize(
                                width: rectFinalOffset.width + drag.translation.width,
                                height: rectFinalOffset.height + drag.translation.height
                            )
                            self.rectActiveOffset.width = workingOffset.width
                            self.rectActiveOffset.height = workingOffset.height
                            
                            activeOffset.width = rectActiveOffset.width - activeRectSize.width / 2
                            activeOffset.height = rectActiveOffset.height - activeRectSize.height / 2
                        }
                        .onEnded{drag in
                            self.rectFinalOffset = rectActiveOffset
                            self.finalOffset = activeOffset
                        }
                )
            
            Image(systemName: "arrow.up.left.and.arrow.down.right")
                .font(.system(size: 12))
                .background(Circle().frame(width: 20, height: 20).foregroundColor(dotColor))
                .frame(width: dotSize, height: dotSize)
                .foregroundColor(.black)
                .offset(x: activeOffset.width, y: activeOffset.height)
                .gesture(
                    DragGesture()
                        .onChanged{drag in
                            let workingOffset = CGSize(
                                width: finalOffset.width + drag.translation.width,
                                height: finalOffset.height + drag.translation.height
                            )
                            
                            let changeInXOffset = finalOffset.width - workingOffset.width
                            let changeInYOffset = finalOffset.height - workingOffset.height
                            
                            if finalRectSize.width + changeInXOffset > 40 && finalRectSize.height + changeInYOffset > 40{
                                self.activeOffset.width = workingOffset.width
                                self.activeOffset.height = workingOffset.height
                                
                                activeRectSize.width = finalRectSize.width + changeInXOffset
                                activeRectSize.height = finalRectSize.height + changeInYOffset
                                
                                rectActiveOffset.width = rectFinalOffset.width - changeInXOffset / 2
                                rectActiveOffset.height = rectFinalOffset.height - changeInYOffset / 2
                            }
                            
                        }
                        .onEnded{drag in
                            self.finalOffset = activeOffset
                            finalRectSize = activeRectSize
                            rectFinalOffset = rectActiveOffset
                        }
                )
        }
        .onAppear {
            activeOffset.width = rectActiveOffset.width - activeRectSize.width / 2
            activeOffset.height = rectActiveOffset.height - activeRectSize.height / 2
            finalOffset = activeOffset
        }
    }
    
    func recognizeText(image: UIImage) {
        let request = VNRecognizeTextRequest { request, error in
            if error != nil {
                completionHandler(nil)
                return
            }
            guard let observations = request.results as? [VNRecognizedTextObservation] else { return }
            let recognizedText = observations.compactMap { observation in
                observation.topCandidates(1).first?.string
            }.joined(separator: "\n")
            completionHandler(recognizedText)
            print(recognizedText, "Recognized text")
        }
        
        let handler = VNImageRequestHandler(cgImage: image.cgImage!, options: [:])
        do {
            try handler.perform([request])
        } catch {
        }
    }
    
    func getCropStartCord() -> CGPoint{
        var cropPoint : CGPoint = CGPoint(x: 0, y: 0)
        cropPoint.x = imageWidth / 2 - (activeRectSize.width / 2 - rectActiveOffset.width )
        cropPoint.y = imageHeight / 2 - (activeRectSize.height / 2 - rectActiveOffset.height )
        return cropPoint
    }
}
