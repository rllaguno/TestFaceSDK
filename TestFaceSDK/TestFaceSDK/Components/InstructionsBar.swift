//
//  InstructionsBar.swift
//  TestFaceSDK
//
//  Created by Rodrigo Llaguno on 21/04/25.
//

import SwiftUI

struct InstructionsBar: View {
  let instruction: Instruction
  
  var body: some View {
    HStack(alignment: .center, spacing: 20) {
      Image(systemName: instruction.image)
        .resizable()
        .scaledToFit()
        .foregroundStyle(.blue)
        .frame(height: 40)
      
      VStack(alignment: .leading) {
        Text(instruction.title)
          .foregroundStyle(.primary)
          .font(.headline)
        
        Text(instruction.description)
          .foregroundStyle(.secondary)
          .font(.callout)
        
      }
      .multilineTextAlignment(.leading)
    }
    .padding()
  }
}
