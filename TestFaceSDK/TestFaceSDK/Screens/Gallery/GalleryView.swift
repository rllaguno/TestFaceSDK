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
        if let image = face.galleryImage {
          image
            .resizable()
            .scaledToFit()
            .rotationEffect(.degrees(90))
            .clipShape(RoundedRectangle(cornerRadius: 10))
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
        face.galleryImage = try await face.pickerItem?.loadTransferable(type: Image.self)
      }
    }
  }
}

#Preview {
  GalleryView(face: .constant(Face()))
}
