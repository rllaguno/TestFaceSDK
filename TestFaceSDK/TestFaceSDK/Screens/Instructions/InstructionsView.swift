//
//  ContentView.swift
//  TestFaceSDK
//
//  Created by Rodrigo Llaguno on 21/04/25.
//

import SwiftUI

struct InstructionsView: View {
  @Binding var face: Face
  
  var body: some View {
    VStack(spacing: 50) {
      Spacer()
      
      Text("Instrucciones")
        .font(.largeTitle.bold())
        .foregroundStyle(.primary)
      
      
      VStack(alignment: .leading, spacing: 5) {
        InstructionsBar(instruction: .capture)
        
        InstructionsBar(instruction: .select)
        
        InstructionsBar(instruction: .compare)
      }
      
      Spacer()
      
      Button{
        face.currentNavigation = .faceCapture
      } label: {
        BlueButton(title: "Iniciar")
      }
      
    }
    .padding()
  }
}

#Preview {
  InstructionsView(face: .constant(Face()))
}
