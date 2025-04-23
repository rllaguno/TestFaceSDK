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
        Text("Iniciar captura facial")
          .foregroundStyle(.blue)
      }
      .task {
        if face.faceCaptureResultsReady && face.faceCaptureResponse?.image?.image != nil {
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
