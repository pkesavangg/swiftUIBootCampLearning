//
//  MultipleImagesPickerView.swift
//  SwiftUIThinkingBootcamp
//
//  Created by Kesavan Panchabakesan on 28/12/23.
//

import SwiftUI

//struct MultipleImagesPickerView: View {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}

#Preview {
    MultipleImagesPickerView()
}


struct MultipleImagePicker: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: MultipleImagePicker

        init(_ parent: MultipleImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            var selectedImages = [UIImage]()
            for item in info {
                if let image = item.value as? UIImage, let imageURL = info[.imageURL] as? URL {
                    selectedImages.append(image)
                    print("Image URL: ", imageURL)
                }
            }

            self.parent.images.append(contentsOf: selectedImages)
            parent.showImagePicker = false
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    @Binding var showImagePicker: Bool
    @Binding var images: [UIImage]

    func makeUIViewController(context: UIViewControllerRepresentableContext<MultipleImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .photoLibrary
        picker.allowsEditing = false
        picker.modalPresentationStyle = .fullScreen
        picker.mediaTypes = ["public.image"]
        picker.videoQuality = .typeHigh
        picker.videoMaximumDuration = TimeInterval(30)
        picker.modalPresentationStyle = .popover
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        uiViewController.popoverPresentationController?.sourceRect = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 0, height: 0))
    }
}

struct MultipleImagesPickerView: View {
    @State private var showImagePicker = false
    @State private var images = [UIImage]()
    
    var body: some View {
        VStack{
            Button("Select Images") {
                self.showImagePicker = true
            }
            .sheet(isPresented: $showImagePicker) {
                MultipleImagePicker(showImagePicker: $showImagePicker, images: $images)
            }
            
        }
    }
    
    
}
