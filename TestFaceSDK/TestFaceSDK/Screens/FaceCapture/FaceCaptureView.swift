//
//  FaceCaptureView.swift
//  TestFaceSDK
//
//  Created by Rodrigo Llaguno on 21/04/25.
//

import SwiftUI

struct FaceCaptureView: View {
  @Binding var face: Face
  
  var body: some View {
    VStack {
      Button {
        face.showFaceCapture()
      } label: {
        Text("Captura Facial")
          .foregroundStyle(.blue)
      }
      .task {
        if face.faceCaptureResultsReady {
          face.currentNavigation = .gallery
        }
      }
    }
    .padding()
  }
}

#Preview {
  FaceCaptureView(face: .constant(Face()))
}
