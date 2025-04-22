//
//  ImageHolder.swift
//  TestFaceSDK
//
//  Created by Rodrigo Llaguno on 23/04/25.
//

import SwiftUI

struct ImageHolder: View {
  let uiImage: UIImage
  
    var body: some View {
      Image(uiImage: uiImage)
        .resizable()
        .scaledToFill()
        .frame(width: 160, height: 200)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
