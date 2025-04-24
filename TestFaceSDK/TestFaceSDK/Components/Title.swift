//
//  Title.swift
//  TestFaceSDK
//
//  Created by Rodrigo Llaguno on 24/04/25.
//

import SwiftUI

struct Title: View {
  let title: String
  var body: some View {
    Text(title)
      .font(.largeTitle.bold())
      .foregroundStyle(.primary)
      .padding(.top, 10)
  }
}

#Preview {
  Title(title: "Test")
}
