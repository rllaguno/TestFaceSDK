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
        InstructionsView(face: $face)
        
      case .faceCapture:
        if face.isInitialized {
          FaceCaptureView(face: $face)
        } else {
          ProgressView()
        }
        
      case .gallery:
        GalleryView(face: $face)
        
      case .comparison:
        ComparisonView(face: $face)
      }
    }
  }
  
}

#Preview {
  NavigationView()
}

