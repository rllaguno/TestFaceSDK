//
//  NavigationView.swift
//  TestFaceSDK
//
//  Created by Rodrigo Llaguno on 21/04/25.
//

import SwiftUI

struct NavigationView: View {
  @State private var face = Face()
  
  var body: some View {
    ZStack {
      switch face.currentNavigation {
      case .instructions:
        InstructionsView(currentNavigation: $face.currentNavigation, initialize: face.initialize)
        
      case .faceCapture:
        if face.isInitialized {
          FaceCaptureView(currentNavigation: $face.currentNavigation, faceCaptureResultsReady: $face.faceCaptureResultsReady, faceCaptureResponse: $face.faceCaptureResponse, showFaceCapture: face.showFaceCapture)
        } else {
          ProgressView()
        }
        
      case .gallery:
        GalleryView(currentNavigation: $face.currentNavigation, pickerItem: $face.pickerItem, galleryImage: $face.galleryImage)
        
      case .comparison:
        ComparisonView(face: $face)
      }
    }
  }
  
}

#Preview {
  NavigationView()
}

