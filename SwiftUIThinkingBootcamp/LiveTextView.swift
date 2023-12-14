//
//  LiveTextView.swift
//  SwiftUIThinkingBootcamp
//
//  Created by Kesavan Panchabakesan on 08/12/23.
//

import SwiftUI
import VisionKit
import PhotosUI

struct AddIngredientsView: View {
    @State private var isEditMode: EditMode =  .active
    @State private var showScan: Bool =  false
    @State private var ingredients: [String] =  ["Product 1"]
    @State private var scannedText: String =  ""
    var body: some View {
            List {
                ForEach(ingredients, id: \.self) { value in
                    HStack{
                        Image(systemName: (isEditMode == .active) ? "Editing" : "minus.circle.fill")
                            .foregroundColor(.red)
                        Text(value)
                    }
                }
                .onDelete(perform: { indexSet in
                    
                })
                .onMove(perform: { indices, newOffset in
                    
                })
                HStack {
                    Spacer()
                    Button(action: {
                        self.showScan = true
                    }, label: {
                        HStack{
                            Image(systemName: "plus.viewfinder")
                            Text("Scan")
                        }
                        
                        .padding(.all, 5)
                        .padding(.horizontal, 10)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    })
                    .padding(.all, 5)
                    Spacer()
                }
            }
            .environment(\.editMode, $isEditMode)
            .overlay {
                ZStack(alignment: .bottom) {
                    if showScan {
                        Color.black.opacity(0.3)
                            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                            .onTapGesture {
                                withAnimation {
                                    showScan = false
                                }
                                
                            }
                        LiveTextFromCameraScan(showScan: $showScan, liveScan: $showScan) { values in
                            ingredients.append(values)
                            print(values, "AddIngredientsView")
                        }
                            .frame(height: UIScreen.main.bounds.height * 0.3)
                    }
                }
            }
    }
}

struct LiveTextFromCameraScan: View {
    @Environment(\.dismiss) var dismiss
    @Binding var showScan: Bool
    @Binding var liveScan: Bool
    @State public var scannedText: String = ""
    var completionHandler: (String) -> Void
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                DataScannerVC(liveScan: $liveScan) { values in
                    print(values, "LiveTextFromCameraScan")
                    if let value = values {
                        scannedText = value
                    }
                }
                    .overlay {
                        VStack(content: {
                            HStack(content: {
                                Spacer()
                                Button(action: {
                                    withAnimation {
                                        dismiss()
                                        showScan = false
                                    }
                                }, label: {
                                    Image(systemName: "xmark.circle.fill")
                                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                        .foregroundColor(.gray)
                                })
                                .padding()
                                
                                Spacer()
                                   Button(action: {
                                       self.showScan = true
                                   }, label: {
                                       Text("Live Text")
                                   })
                                   Spacer()
                            })
                            Spacer()
                            Button("Insert") {
                                dismiss()
                                showScan = false
                                completionHandler(scannedText)
                            }
                            .disabled(scannedText.isEmpty)
                            .padding(.bottom)
                            .buttonStyle(.borderedProminent)
                        })
                    }
            }
            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        }
    }
}

struct DataScannerVC: UIViewControllerRepresentable {
   // @Binding var scannedText: String
    @Binding var liveScan: Bool
    var completionHandler: (String?) -> Void
    func makeUIViewController(context: Context) -> DataScannerViewController {
        let viewController = DataScannerViewController(recognizedDataTypes: [.text()],
                                                       qualityLevel: .fast,
                                                       isHighlightingEnabled: true)
        viewController.delegate = context.coordinator
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: DataScannerViewController, context: Context) {
        if liveScan {
            try? uiViewController.startScanning()
        } else {
            uiViewController.stopScanning()
        }
    }
    
    class Coordinator: NSObject, DataScannerViewControllerDelegate {
        var parent: DataScannerVC
        init(parent: DataScannerVC) {
            self.parent = parent
        }
        
        func dataScanner(_ dataScanner: DataScannerViewController, didTapOn item: RecognizedItem) {
            switch item {
            case .text(let text):
              //  parent.scannedText = text.transcript
                parent.liveScan = false
            default:
                break
            }
        }
        func dataScanner(_ dataScanner: DataScannerViewController, didUpdate updatedItems: [RecognizedItem], allItems: [RecognizedItem]) {
            
            switch updatedItems[0] {
            case .text(let text):
                parent.completionHandler(text.transcript)
              //  parent.scannedText = text.transcript
                
            default:
                break
            }
            
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
}


struct LiveTextView: View {
    @StateObject var imagePicker = ImagePicker2()
    @State private var scannedText = ""
    @FocusState var focusState: Bool
    @State var liveScan = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20 ) {
                TextEditor(text: $scannedText)
                    .frame(height: 300)
                    .border(Color.gray)
                    .focused($focusState)
                if DataScannerViewController.isSupported {
                    Button("Scan with Camera") {
                        liveScan.toggle()
                        focusState = false
                    }
                    .buttonStyle(.borderedProminent)
                } else {
                    Text("Does not support Live Text from camera scan.")
                }
                if ImageAnalyzer.isSupported {
                    PhotosPicker(selection: $imagePicker.imageSelection, matching: .images, photoLibrary: .shared()) {
                        Text("Select Image")
                    }
                    .buttonStyle(.borderedProminent)
                } else {
                    Text("Does not support Live Text scanning from image.")
                }
                Spacer()
            }
            .padding()
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button {
                        focusState = false
                    } label: {
                        Image(systemName: "keyboard.chevron.compact.down.fill")
                    }
                }
            }
            .navigationTitle("Live Text")
            .sheet(isPresented: $liveScan) {
                LiveTextFromCameraScan(showScan: .constant(true), liveScan: $liveScan) { values in
                    
                }
                
            }
            .sheet(item: $imagePicker.imageToScan) { imageToScan in
                TextFromImageView(imageToScan: imageToScan.image, scannedText: $scannedText)
            }
        }
    }
}

struct TestView: View {
    @State private var items = ["Apple", "Orange"]
    @State private var isEditMode: EditMode = .inactive

    var body: some View {
        NavigationView {
            
            ZStack {
                Color.red
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    .overlay {
                        ExtractedView()
                           
                    }
                
            }

            .navigationBarItems(trailing: EditButton())
            
        }
    }

    func deleteItem(offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }
}

#Preview {
    AddIngredientsView()
}

import SwiftUI
import PhotosUI

@MainActor
class ImagePicker2: ObservableObject {
    @Published var image: Image?
    @Published var images: [Image] = []
    @Published var imageToScan: ImageToScan?
    
    @Published var imageSelection: PhotosPickerItem? {
        didSet {
            if let imageSelection {
                Task {
                    try await loadTransferable(from: imageSelection)
                }
            }
        }
    }
    
    @Published var imageSelections: [PhotosPickerItem] = [] {
        didSet {
            Task {
                if !imageSelections.isEmpty {
                    try await loadTransferable(from: imageSelections)
                    imageSelections = []
                }
            }
        }
    }
    
    func loadTransferable(from imageSelections: [PhotosPickerItem]) async throws {
        do {
            for imageSelection in imageSelections {
                if let data = try await imageSelection.loadTransferable(type: Data.self) {
                    if let uiImage = UIImage(data: data) {
                        self.imageToScan = ImageToScan(image: uiImage)
                        self.images.append(Image(uiImage: uiImage))
                    }
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func loadTransferable(from imageSelection: PhotosPickerItem?) async throws {
        do {
            if let data = try await imageSelection?.loadTransferable(type: Data.self) {
                if let uiImage = UIImage(data: data) {
                    self.imageToScan = ImageToScan(image: uiImage)
                    self.image = Image(uiImage: uiImage)
                }
            }
        } catch {
            print(error.localizedDescription)
            image = nil
        }
    }
}

struct ImageToScan: Identifiable, Equatable {
    let id = UUID()
    let image: UIImage
}


@MainActor
struct LiveTextUIImageView: UIViewRepresentable {
    var image: UIImage
    let analyzer = ImageAnalyzer()
    let interaction = ImageAnalysisInteraction()
    let imageView = ResizableImageView()
    func makeUIView(context: Context) -> UIImageView {
        imageView.image = image
        imageView.addInteraction(interaction)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
    
    func updateUIView(_ uiView: UIImageView, context: Context) {
        Task {
            do {
                let configuration = ImageAnalyzer.Configuration([.text])
                if let image = imageView.image {
                    let analysis = try await analyzer.analyze(image, configuration: configuration)
                    interaction.analysis = analysis
                    interaction.preferredInteractionTypes = .textSelection
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    
}

class ResizableImageView: UIImageView {
    override var intrinsicContentSize: CGSize {
        .zero
    }
}


import SwiftUI

struct TextFromImageView: View {
    @Environment(\.dismiss) var dismiss
    private let pastboard = UIPasteboard.general
    let imageToScan: UIImage
    @Binding var scannedText: String
    
    @State private var currentPastboard = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                LiveTextUIImageView(image: imageToScan)
                Text("Select some text and copy it")
                Button("Dismiss") {
                    if let string = pastboard.string {
                        if !string.isEmpty {
                            scannedText = string
                        }
                    }
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
            }
            .navigationTitle("Copy Text")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                pastboard.string = ""
            }
        }
    }
}

struct TextFromImageView_Previews: PreviewProvider {
    static var previews: some View {
        TextFromImageView(imageToScan: UIImage(), scannedText: .constant(""))
    }
}

struct ExtractedView: View {
    var body: some View {
        List {
            ForEach(["items"], id: \.self) { item in
                Text(item)
            }
        }
    }
}
