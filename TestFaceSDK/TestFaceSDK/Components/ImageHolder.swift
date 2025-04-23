//
//  ImageHolder.swift
//  TestFaceSDK
//
//  Created by Rodrigo Llaguno on 23/04/25.
//

import SwiftUI

struct ImageHolder: View {
  let uiImage: UIImage
  let title: String
  
    var body: some View {
      VStack(alignment: .center, spacing: 10) {
        Image(uiImage: uiImage)
          .resizable()
          .scaledToFill()
          .frame(width: 160, height: 200)
          .clipShape(RoundedRectangle(cornerRadius: 10))
        
        if title != "" {
          Text(title)
            .font(.caption)
        }
      }
    }
}
