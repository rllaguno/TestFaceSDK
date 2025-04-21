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
    ProgressView()
      .onAppear {
        face.showFaceCapture()
      }
  }
}

#Preview {
  FaceCaptureView(face: .constant(Face()))
}
