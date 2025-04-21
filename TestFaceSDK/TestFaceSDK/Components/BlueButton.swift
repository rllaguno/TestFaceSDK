//
//  BlueButton.swift
//  TestFaceSDK
//
//  Created by Rodrigo Llaguno on 21/04/25.
//

import SwiftUI

struct BlueButton: View {
  let title: String
  
    var body: some View {
      ZStack {
        Rectangle()
          .fill(.blue)
          .frame(maxHeight: 50)
          .clipShape(.rect(cornerRadius: 10))
        
        Text(title)
          .foregroundStyle(.white)
          .font(.headline)
      }    }
}

#Preview {
  BlueButton(title: "Iniciar")
}
