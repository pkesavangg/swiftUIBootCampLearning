//
//  GetTextFromImageView.swift
//  SwiftUIThinkingBootcamp
//
//  Created by Kesavan Panchabakesan on 30/12/23.
//

enum RecipeField: String, CaseIterable {
    case title, cookingHrs, category, notes, directions, ingredients
}

import SwiftUI
import UIKit
import PDFKit
import Foundation
import Vision

class GetTextFromImageViewModel: ObservableObject {
    @Published public var title: String = ""
        @Published public var cookingHrs: String = ""
        @Published public var category: String = ""
        @Published public var ingredients: String = ""
        @Published public var directions: String = ""
        @Published public var notes: String = ""
        @Published public var imageFilePath: String?
        @Published public var selectedTexts: [String] = []
        @Published public var selectedField: RecipeField = .title
}

struct TextFieldView: View {
    public var placeholder: String = ""
    public var label: String = ""
    @Binding public var text: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
            TextField(placeholder, text: $text)
                .textFieldStyle(.roundedBorder)
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color.black, lineWidth: 1.5)
                )
        }
        .padding()
        
    }
}


struct ScanFromPhotoView: View {
    @ObservedObject public var viewModel: GetTextFromImageViewModel
    @StateObject private var cropViewModel = ImageCropViewModel()
    @State var showImagePicker: Bool = false
    @State var imageDataString: String?
    @State public var showingOptions = false
    @State var image: UIImage? = UIImage(named: "Image1")
    @State public var sourceType: UIImagePickerController.SourceType = .camera
    @State public var resultedImages: [UIImage?] = []
    @State private var selectedTexts: [String] = ["testin"]
    @State private var selectedField: RecipeField = .title
    @State private var showFieldOptions = false
    @State private var showEmptyTextAlert = false
    var body: some View {
        VStack {
            if image != nil {
                ImageCropView23(image: $image, viewModel: cropViewModel) { text in
                    if let text = text {
                        selectedTexts.append(text)
                    }
                }
                .frame(height: 500)
                ForEach(selectedTexts, id: \.self) { text in
                    Text(text)
                    
                }
            }
        }
        .sheet(isPresented: $showImagePicker, content: {
            RecipeImagePickerView(isShown: $showImagePicker, imageDataString: $imageDataString, fileName: $viewModel.imageFilePath, sourceType: sourceType, image: $image)
        })
        .alert(isPresented: $showEmptyTextAlert, content: {
            Alert(title: Text("No Text Found"), message: Text("No text found in the selection. Try adjusting the selection to surround the required text."))
        })
        .toolbar(content: {
            ToolbarItem(placement: .bottomBar) {
                HStack {
                    Button(action: {
                        showingOptions = true
                    }, label: {
                        Text("Choose photo")
                    })
                    .confirmationDialog("Choose Image", isPresented: $showingOptions, titleVisibility: .visible) {
                        Button("Camera") {
                            showImagePicker = true
                            sourceType = .camera
                        }
                        
                        Button("Gallery") {
                            showImagePicker = true
                            sourceType = .photoLibrary
                        }
                    }
                    Spacer()
                    if image != nil {
                        Menu {
                            ForEach(RecipeField.allCases, id: \.self) { field in
                                Button {
                                    selectedField = field
                                    getText()
                                } label: {
                                    Text(field.rawValue.capitalized)
                                }
                            }
                        } label: {
                            Text("Recognize Text")
                        }
                    }
                    
                }
                
            }
        })
    }
    
    func getText() {
        let cgImage: CGImage = (image?.cgImage!)!
        let scaler = CGFloat(cgImage.width)/cropViewModel.imageWidth
        if let cImage = cgImage.cropping(to: CGRect(x: cropViewModel.getCropStartCord().x * scaler, y: cropViewModel.getCropStartCord().y * scaler, width: cropViewModel.activeRectSize.width * scaler, height: cropViewModel.activeRectSize.height * scaler)){
            cropViewModel.recognizeText(image: UIImage(cgImage: cImage)) {
                text in
                if let text = text {
                    if text.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
                        showEmptyTextAlert = true
                    } else {
                        switch selectedField {
                        case .title:
                            viewModel.title = text
                        case .cookingHrs:
                            viewModel.cookingHrs = text
                        case .category:
                            viewModel.category = text
                        case .notes:
                            viewModel.notes = text
                        case .directions:
                            viewModel.directions = text
                        case .ingredients:
                            viewModel.ingredients = text
                        }
                    }
                    selectedTexts.append(text)
                }
                
            }
        }
    }
    
}



#Preview {
    GetTextFromImageView()
    
    //    ImageCropView23(image: .constant(UIImage(named: "Image1"))) { _ in
    //
    //    }
    
    //    ImageCropper(image: Image("myImage"), onFinished: { image in
    //                // Handle the cropped image
    //            })
}


struct ImageCropView23: View {
    @Binding var image: UIImage?
    @ObservedObject public var viewModel: ImageCropViewModel
    @State private var dotSize: CGFloat = 13
    var dotColor = Color.init(white: 1).opacity(0.9)
    
    public let completionHandler: (String?) -> Void
    
    var body: some View {
        VStack {
            ZStack {
                Image(uiImage: image ?? UIImage())
                    .resizable()
                    .scaledToFit()
                    .overlay(GeometryReader { geo -> AnyView in
                        DispatchQueue.main.async {
                            self.viewModel.imageWidth = geo.size.width
                            self.viewModel.imageHeight = geo.size.height
                        }
                        return AnyView(EmptyView())
                    })
                
                //                Button(action: {
                //                    let cgImage: CGImage = (image?.cgImage!)!
                //                    let scaler = CGFloat(cgImage.width)/viewModel.imageWidth
                //                    if let cImage = cgImage.cropping(to: CGRect(x: viewModel.getCropStartCord().x * scaler, y: viewModel.getCropStartCord().y * scaler, width: viewModel.activeRectSize.width * scaler, height: viewModel.activeRectSize.height * scaler)){
                //                        viewModel.recognizeText(image: UIImage(cgImage: cImage)) {
                //                            text in
                //
                //                        }
                //                    }
                //                   // pm.wrappedValue.dismiss()
                //                }, label: {
                //                    Text("Recognize Text")
                //                        .padding()
                //                        .foregroundColor(.white)
                //                        .background(Capsule().fill(Color.blue))
                //
                //                })
                //                .offset(y: 200)
                
                Rectangle()
                    .stroke(lineWidth: 1.5)
                    .foregroundColor(.yellow)
                    .offset(x: viewModel.rectActiveOffset.width, y: viewModel.rectActiveOffset.height)
                    .frame(width: viewModel.activeRectSize.width, height: viewModel.activeRectSize.height)
                
                Rectangle()
                    .stroke(lineWidth: 1)
                    .foregroundColor(.yellow)
                    .background(Color.gray.opacity(0.3))
                    .offset(x: viewModel.rectActiveOffset.width, y: viewModel.rectActiveOffset.height)
                    .frame(width: viewModel.activeRectSize.width, height: viewModel.activeRectSize.height)
                    .gesture(
                        DragGesture()
                            .onChanged{drag in
                                print(drag.translation.height, "Height")
                                let workingOffset = CGSize(
                                    width: viewModel.rectFinalOffset.width + drag.translation.width,
                                    height: viewModel.rectFinalOffset.height + drag.translation.height
                                )
                                self.viewModel.rectActiveOffset.width = workingOffset.width
                                self.viewModel.rectActiveOffset.height = workingOffset.height
                                
                                viewModel.activeOffset.width = viewModel.rectActiveOffset.width - viewModel.activeRectSize.width / 2
                                viewModel.activeOffset.height = viewModel.rectActiveOffset.height - viewModel.activeRectSize.height / 2
                            }
                            .onEnded{drag in
                                self.viewModel.rectFinalOffset = viewModel.rectActiveOffset
                                self.viewModel.finalOffset = viewModel.activeOffset
                                
                            }
                    )
                
                Image(systemName: "arrow.up.left.and.arrow.down.right")
                    .font(.system(size: 12))
                    .background(Circle().frame(width: 20, height: 20).foregroundColor(dotColor))
                    .frame(width: dotSize, height: dotSize)
                    .foregroundColor(.black)
                    .offset(x: viewModel.activeOffset.width, y: viewModel.activeOffset.height)
                    .gesture(
                        DragGesture()
                            .onChanged{drag in
                                let workingOffset = CGSize(
                                    width: viewModel.finalOffset.width + drag.translation.width,
                                    height: viewModel.finalOffset.height + drag.translation.height
                                )
                                
                                let changeInXOffset = viewModel.finalOffset.width - workingOffset.width
                                let changeInYOffset = viewModel.finalOffset.height - workingOffset.height
                                
                                if viewModel.finalRectSize.width + changeInXOffset > 20
                                    && viewModel.finalRectSize.width + changeInXOffset <  viewModel.imageWidth
                                    && viewModel.finalRectSize.height + changeInYOffset > 20 && viewModel.finalRectSize.height + changeInYOffset < viewModel.imageHeight{
                                    self.viewModel.activeOffset.width = workingOffset.width
                                    self.viewModel.activeOffset.height = workingOffset.height
                                    
                                    viewModel.activeRectSize.width = viewModel.finalRectSize.width + changeInXOffset
                                    viewModel.activeRectSize.height = viewModel.finalRectSize.height + changeInYOffset
                                    viewModel.rectActiveOffset.width = viewModel.rectFinalOffset.width - changeInXOffset / 2
                                    viewModel.rectActiveOffset.height = viewModel.rectFinalOffset.height - changeInYOffset / 2
                                    
                                }
                                
                            }
                            .onEnded{drag in
                                self.viewModel.finalOffset = viewModel.activeOffset
                                viewModel.finalRectSize = viewModel.activeRectSize
                                viewModel.rectFinalOffset = viewModel.rectActiveOffset
                            }
                    )
                // ... (rest of your code)
            }
            .onAppear {
                viewModel.activeOffset.width = viewModel.rectActiveOffset.width - viewModel.activeRectSize.width / 2
                viewModel.activeOffset.height = viewModel.rectActiveOffset.height - viewModel.activeRectSize.height / 2
                viewModel.finalOffset = viewModel.activeOffset
            }
        }
    }
}

struct ImageCropView232: View {
    //  @Environment(\.presentationMode) var pm
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
    
    @State var activeRectSize : CGSize = CGSize(width: 150, height: 50)
    @State var finalRectSize : CGSize = CGSize(width: 150, height: 50)
    public let completionHandler: (String?) -> Void
    var body: some View {
        VStack {
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
                    // pm.wrappedValue.dismiss()
                }, label: {
                    Text("Recognize Text")
                        .padding()
                        .foregroundColor(.white)
                        .background(Capsule().fill(Color.blue))
                    
                })
                .offset(y: 200)
                
                Rectangle()
                    .stroke(lineWidth: 1.5)
                    .foregroundColor(.yellow)
                    .offset(x: rectActiveOffset.width, y: rectActiveOffset.height)
                    .frame(width: activeRectSize.width, height: activeRectSize.height)
                
                Rectangle()
                    .stroke(lineWidth: 1)
                    .foregroundColor(.yellow)
                    .background(Color.gray.opacity(0.3))
                    .offset(x: rectActiveOffset.width, y: rectActiveOffset.height)
                    .frame(width: activeRectSize.width, height: activeRectSize.height)
                    .gesture(
                        DragGesture()
                            .onChanged{drag in
                                print(drag.translation.height, "Height")
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
                                
                                if finalRectSize.width + changeInXOffset > 20
                                    && finalRectSize.width + changeInXOffset <  imageWidth
                                    && finalRectSize.height + changeInYOffset > 20 && finalRectSize.height + changeInYOffset < imageHeight{
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




import SwiftUI
import Vision

class ImageCropViewModel: ObservableObject {
    @Published var imageWidth: CGFloat = 0
    @Published var imageHeight: CGFloat = 0
    @Published var activeOffset: CGSize = CGSize(width: 0, height: 0)
    @Published var finalOffset: CGSize = CGSize(width: 0, height: 0)
    @Published var rectActiveOffset: CGSize = CGSize(width: 0, height: 0)
    @Published var rectFinalOffset: CGSize = CGSize(width: 0, height: 0)
    @Published var activeRectSize: CGSize = CGSize(width: 150, height: 50)
    @Published var finalRectSize: CGSize = CGSize(width: 150, height: 50)
    
    func getCropStartCord() -> CGPoint {
        var cropPoint: CGPoint = CGPoint(x: 0, y: 0)
        cropPoint.x = imageWidth / 2 - (activeRectSize.width / 2 - rectActiveOffset.width)
        cropPoint.y = imageHeight / 2 - (activeRectSize.height / 2 - rectActiveOffset.height)
        return cropPoint
    }
    
    func recognizeText(image: UIImage, completionHandler: @escaping (String?) -> Void) {
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
}




struct GetTextFromImageView: View {
    @StateObject public var viewModel = GetTextFromImageViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                TextFieldView(placeholder: "Title", label: "Title", text: $viewModel.title)
                TextFieldView(placeholder: "Cooking Hours", label: "Cooking Hours", text: $viewModel.cookingHrs)
                TextFieldView(placeholder: "Category", label: "Category", text: $viewModel.category)
                TextFieldView(placeholder: "Ingredients", label: "Ingredients", text: $viewModel.ingredients)
                TextFieldView(placeholder: "Directions", label: "Directions", text: $viewModel.directions)
                TextFieldView(placeholder: "Notes", label: "Notes", text: $viewModel.notes)
                
                NavigationLink {
                    ScanFromPhotoView(viewModel: viewModel)
                } label: {
                    Text("Add via photo")
                        .padding(.all, 10)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .buttonStyle(.borderedProminent)
                .padding()
            }
            
        }
        
    }
}


struct RecipeImagePickerView: UIViewControllerRepresentable {
    
    let isShown: Binding<Bool>
    let imageDataString: Binding<String?>
    var sourceType: UIImagePickerController.SourceType = .camera
    let fileName: Binding<String?>
    let image: Binding<UIImage?>
    
    init(isShown: Binding<Bool>, imageDataString: Binding<String?>, fileName: Binding<String?>, sourceType: UIImagePickerController.SourceType, image: Binding<UIImage?>) {
        self.isShown = isShown
        self.imageDataString = imageDataString
        self.sourceType = sourceType
        self.fileName = fileName
        self.image = image
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        
        let isShown: Binding<Bool>
        let imageDataString: Binding<String?>
        var fileName: Binding<String?>
        var image: Binding<UIImage?>
        
        init(isShown: Binding<Bool>, imageDataString: Binding<String?>, fileName: Binding<String?>, image: Binding<UIImage?>) {
            self.isShown = isShown
            self.imageDataString = imageDataString
            self.fileName = fileName
            self.image = image
        }
        
        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                //                TODO: To convert the image into string commented for future use.
                //                if let imageData = uiImage.jpegData(compressionQuality: 0.8) {
                //                    self.imageDataString.wrappedValue = imageData.base64EncodedString()
                //                }
                self.image.wrappedValue = uiImage
                if let fileName = FileManagerHelper.shared.saveImage(uiImage) {
                    self.fileName.wrappedValue = fileName
                }
            }
            self.isShown.wrappedValue = false
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            isShown.wrappedValue = false
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(isShown: isShown, imageDataString: imageDataString, fileName: fileName, image: image)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<RecipeImagePickerView>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = sourceType
        picker.modalPresentationStyle = .popover
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController,
                                context: UIViewControllerRepresentableContext<RecipeImagePickerView>) {
    }
}
