//
//  ComparisonView.swift
//  TestFaceSDK
//
//  Created by Rodrigo Llaguno on 22/04/25.
//

import SwiftUI

struct ComparisonView: View {
  @Binding var face: Face
  @State private var completedLoading: Bool = false
  let timer = Timer.publish(every: 4, on: .main, in: .common).autoconnect()
  
  var body: some View {
    VStack {
      Text("Resultados")
        .font(.largeTitle)
        .bold()
      
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
        
        if face.faceCaptureResultsReady {
          if completedLoading {
            VStack(alignment: .leading, spacing: 10) {
              
              Text("\(face.similarityPercentage)%")
                .font(.system(size: 150, weight: .bold))
              
              Text("de similitud")
                .font(.system(size: 20, weight: .bold))
            }
          } else {
            ProgressView()
              .onReceive(timer) { time in
                withAnimation(.easeOut(duration: 1.5)) {
                  completedLoading = true
                }
                timer.upstream.connect().cancel()
              }
          }
        }
        
      }
      
      Spacer()
      
      Button {
        face.currentNavigation = .instructions
        face.reset()
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
