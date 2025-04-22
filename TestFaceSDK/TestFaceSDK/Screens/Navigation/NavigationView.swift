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
      if face.isInitialized {
        switch face.currentNavigation {
        case .instructions:
          InstructionsView(face: $face)
          
        case .faceCapture:
          FaceCaptureView(face: $face)
          
        case .gallery:
          GalleryView(face: $face)
          
        case .comparison:
          ComparisonView(face: $face)
        }
      } else {
        ProgressView()
      }
    }
    
  }
  
}

#Preview {
  NavigationView()
}

