//
//  GalleryView.swift
//  TestFaceSDK
//
//  Created by Rodrigo Llaguno on 22/04/25.
//

import SwiftUI
import PhotosUI

struct GalleryView: View {
  @Binding var currentNavigation: NavigationIndex
  @Binding var pickerItem: PhotosPickerItem?
  @Binding var galleryImage: UIImage?
  
  var body: some View {
    VStack {
      
      Spacer()
      
      if galleryImage == nil {
        PhotosPicker("Selecciona una imagen con tu rostro", selection: $pickerItem, matching: .images)
      } else {
        if let uiImage = galleryImage {
          VStack(spacing: 10) {
            ImageHolder(uiImage: uiImage, title: "")
            
            Button {
              galleryImage = nil
              pickerItem = nil
            } label: {
              Text("Borrar imagen")
                .foregroundStyle(.blue)
            }
          }
        }
      }
      
      Spacer()
      
      Button {
        currentNavigation = .comparison
      } label: {
        BlueButton(title: "Continuar")
          .opacity(galleryImage == nil ? 0.5 : 1.0)
      }
      .disabled(galleryImage == nil)
    }
    .padding()
    .onChange(of: pickerItem) {
      Task {
        if let data = try? await pickerItem?.loadTransferable(type: Data.self), let uiImage = UIImage(data: data) {
          galleryImage = uiImage
        }
      }
    }
  }
}
