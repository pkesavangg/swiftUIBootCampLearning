//
//  GetImageFromDeviceView.swift
//  SwiftUIThinkingBootcamp
//
//  Created by Kesavan Panchabakesan on 28/12/23.
//



import SwiftUI
import UIKit

struct ImageCollectionView: View {
    var images: [UIImage]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(images, id: \.self) { image in
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 100, height: 100)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
    }
}



struct GetImageFromDeviceView: View {
    @State var showImagePicker: Bool = false
    @State var imageDataString: String?
    @State var fileName: String?
    @State public var showingOptions = false
    @State public var sourceType: UIImagePickerController.SourceType = .camera
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Button(action: {
                        withAnimation {
                            showingOptions = true
                        }
                    }) {
                        Text("Show image picker")
                            .padding(.horizontal)
                    }
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
                    .buttonStyle(.borderedProminent)
                    .padding()
                    
                    Group {
                        if let fileName = fileName {
                            if let uiImage = FileManagerHelper.shared.loadImage(fileName: fileName) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .frame(width: .infinity, height: 250)
                                Text(fileName)
                            }
                        }
                         else {
                            Rectangle()
                                .fill(Color.gray)
                                .frame(width: 250, height: 250)
                        }
                    }
                    .cornerRadius(10)
                    Spacer()
                }
                if (showImagePicker) {
                    ImagePickerFromGalleryView(isShown: $showImagePicker, imageDataString: $imageDataString, fileName: $fileName, sourceType: sourceType)
                }
            }
            .navigationTitle("Image Picker")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ImagePickerFromGalleryView: UIViewControllerRepresentable {
    let isShown: Binding<Bool>
    let imageDataString: Binding<String?>
    let fileName: Binding<String?>
    var sourceType: UIImagePickerController.SourceType = .camera
    
    
    init(isShown: Binding<Bool>, imageDataString: Binding<String?>, fileName: Binding<String?>, sourceType: UIImagePickerController.SourceType) {
        self.isShown = isShown
        self.imageDataString = imageDataString
        self.sourceType = sourceType
        self.fileName = fileName
    }
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        
        let isShown: Binding<Bool>
        let imageDataString: Binding<String?>
        var fileName: Binding<String?>
        
        init(isShown: Binding<Bool>, imageDataString: Binding<String?>, fileName: Binding<String?>) {
            self.isShown = isShown
            self.imageDataString = imageDataString
            self.fileName = fileName
        }
        

        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                if let imageData = uiImage.jpegData(compressionQuality: 0.8) {
                    self.imageDataString.wrappedValue = imageData.base64EncodedString()
                    
                    // Save the image to file manager
                    if let fileName = FileManagerHelper.shared.saveImage(uiImage) {
                        self.fileName.wrappedValue = fileName
                    }

                }
            }
            self.isShown.wrappedValue = false
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            isShown.wrappedValue = false
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(isShown: isShown, imageDataString: imageDataString, fileName: fileName)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePickerFromGalleryView>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = sourceType
        picker.modalPresentationStyle = .popover
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController,
                                context: UIViewControllerRepresentableContext<ImagePickerFromGalleryView>) {
    }
}



#Preview {
    GetImageFromDeviceView( sourceType: .camera)
}


class FileManagerHelper {
    static let shared = FileManagerHelper()
    
    private init() {}
    
    func saveImage(_ image: UIImage) -> String?{
        if let data = image.jpegData(compressionQuality: 1.0) {
            let randomFileName = generateRandomFileName()
            let fileURL = getFileURL(fileName: randomFileName)
            try? data.write(to: fileURL)
            return randomFileName
        }
        return nil
    }
    
    func loadImage(fileName: String) -> UIImage? {
        let fileURL = getFileURL(fileName: fileName)
        if let data = try? Data(contentsOf: fileURL) {
            return UIImage(data: data)
        }
        return nil
    }
    
    private func getFileURL(fileName: String) -> URL {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsDirectory.appendingPathComponent(fileName)
    }
    
    private func generateRandomFileName() -> String {
        let uuid = UUID().uuidString
        return "image_\(uuid).jpg"
    }
}
