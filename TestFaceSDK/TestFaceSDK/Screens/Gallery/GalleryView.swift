//
//  GalleryView.swift
//  TestFaceSDK
//
//  Created by Rodrigo Llaguno on 22/04/25.
//

import SwiftUI
import PhotosUI

struct GalleryView: View {
  @Binding var face: Face
  
  var body: some View {
    VStack {
      
      Spacer()
      
      if face.galleryImage == nil {
        PhotosPicker("Selecciona una imagen con tu rostro", selection: $face.pickerItem, matching: .images)
      } else {
        if let uiImage = face.galleryImage {
          VStack(spacing: 10) {
            ImageHolder(uiImage: uiImage)
            
            Button {
              face.galleryImage = nil
              face.pickerItem = nil
            } label: {
              Text("Borrar imagen")
                .foregroundStyle(.blue)
            }
          }
        }
      }
      
      Spacer()
      
      Button {
        face.currentNavigation = .comparison
      } label: {
        BlueButton(title: "Continuar")
      }
    }
    .padding()
    .onChange(of: face.pickerItem) {
      Task {
        if let data = try? await face.pickerItem?.loadTransferable(type: Data.self), let uiImage = UIImage(data: data) {
          face.galleryImage = uiImage
        }
      }
    }
  }
}

#Preview {
  GalleryView(face: .constant(Face()))
}
