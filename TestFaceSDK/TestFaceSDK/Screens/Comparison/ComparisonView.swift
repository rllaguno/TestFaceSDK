//
//  ComparisonView.swift
//  TestFaceSDK
//
//  Created by Rodrigo Llaguno on 22/04/25.
//

import SwiftUI

struct ComparisonView: View {
  @Binding var face: Face
  
  var body: some View {
    VStack {
      Title(title: "Resultados")
      
      Spacer()
      
      VStack(spacing: 50) {
        
        HStack(spacing: 10) {
          if let uiImageCapture = face.faceCaptureResponse?.image?.image {
            ImageHolder(uiImage: uiImageCapture, title: "Captura facial")
          }
          
          if let uiImageGallery = face.galleryImage {
            ImageHolder(uiImage: uiImageGallery, title: "Imagen de galería")
          }
        }
        
        if face.matchFaceResponseReady {
          VStack(alignment: .leading, spacing: 10) {
            
            Text("\(face.similarityPercentage)%")
              .font(.system(size: 150, weight: .bold))
            
            Text("de similitud")
              .font(.system(size: 20, weight: .bold))
          }
        } else {
          ProgressView()
        }
        
      }
      
      Spacer()
      
      Button {
        face.currentNavigation = .instructions
        face.reset()
        face.deinitialize()
      } label: {
        BlueButton(title: "Volver al inicio")
      }
    }
    .padding()
    .onAppear() {
      face.makeComparison()
    }
  }
}

#Preview {
  ComparisonView(face: .constant(Face()))
}
