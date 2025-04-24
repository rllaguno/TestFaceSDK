//
//  FaceCaptureView.swift
//  TestFaceSDK
//
//  Created by Rodrigo Llaguno on 21/04/25.
//

import SwiftUI
import FaceSDK

struct FaceCaptureView: View {
  @Binding var currentNavigation: NavigationIndex
  @Binding var faceCaptureResultsReady: Bool
  @Binding var faceCaptureResponse: FaceCaptureResponse?
  var showFaceCapture: () -> Void
  
  var body: some View {
    VStack {
      Button {
        showFaceCapture()
      } label: {
        Text("Iniciar captura facial")
          .foregroundStyle(.blue)
      }
      .task {
        if faceCaptureResultsReady && faceCaptureResponse?.image?.image != nil {
          currentNavigation = .gallery
        }
      }
    }
    .padding()
  }
}
