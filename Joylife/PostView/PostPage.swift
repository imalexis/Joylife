//
//  PostPage.swift
//  Joylife
//
//  Created by alexis on 14/4/21.
//

import SwiftUI
import UIKit

struct ImagePickerView: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    // 用于控制background navigation link是否active
    @Binding var isActive: Bool
    @Environment(\.presentationMode) var isPresented
    var sourceType: UIImagePickerController.SourceType
    
    

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = self.sourceType
        imagePicker.delegate = context.coordinator
        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        return Coordinator(picker: self)
    }
}

class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var picker: ImagePickerView

    init(picker: ImagePickerView) {
        self.picker = picker
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else {
            return
        }
        self.picker.selectedImage = selectedImage
        self.picker.isPresented.wrappedValue.dismiss()
        self.picker.isActive = true
        print("isactive", self.picker.isActive)
    }
}

struct PostPage: View {
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var selectedImage: UIImage? = nil
    @State private var isImagePickerDisplay = false
    @State private var isActive = false


    var body: some View {
        VStack {
            if !isActive {
            Form {
                Section {
                    Button(action: {
                        self.sourceType = .photoLibrary
                        self.isImagePickerDisplay.toggle()
                    }, label: {
                        HStack {
                            Text("Photo")
                            Spacer()
                            Image(systemName: "photo")
                        }.accentColor(.black)
                    })

                    Button(action: {
                        self.sourceType = .camera
                        self.isImagePickerDisplay.toggle()
                    }, label: {
                        HStack {
                            Text("Camera")
                            Spacer()
                            Image(systemName: "camera")
                        }.accentColor(.black)
                    })
                }
            }
        } else {
            PostEditPage(selectedImage: $selectedImage, isActive: $isActive)
        }
        }
        .sheet(isPresented: $isImagePickerDisplay) {
            ImagePickerView(selectedImage: self.$selectedImage, isActive: $isActive, sourceType: self.sourceType)
        }
    }
}

struct PostPage_Previews: PreviewProvider {
    static var previews: some View {
        PostPage()
    }
}
