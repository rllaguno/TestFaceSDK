//
//  ContentView.swift
//  TestFaceSDK
//
//  Created by Rodrigo Llaguno on 21/04/25.
//

import SwiftUI

struct InstructionsView: View {
  @Binding var currentNavigation: NavigationIndex
  var initialize: () -> Void
  
  var body: some View {
    VStack(spacing: 50) {
      Title(title: "Instrucciones")
      
      Spacer()
      
      VStack(alignment: .leading, spacing: 5) {
        InstructionsBar(instruction: .capture)
        
        InstructionsBar(instruction: .select)
        
        InstructionsBar(instruction: .compare)
      }
      
      Spacer()
      
      Button{
        initialize()
        currentNavigation = .faceCapture
      } label: {
        BlueButton(title: "Iniciar")
      }
      
    }
    .padding()
  }
}
