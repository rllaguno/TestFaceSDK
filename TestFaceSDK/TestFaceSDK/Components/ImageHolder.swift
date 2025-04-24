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
  let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
  
  @State private var animated: Bool = false
  
    var body: some View {
      VStack(alignment: .center, spacing: 10) {
        ZStack {
          Rectangle()
            .frame(width: 170, height: 210)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .foregroundStyle(.blue)
            .opacity(animated ? 0.6 : 1.0)
            .onReceive(timer) { _ in
              withAnimation(.smooth) {
                animated.toggle()
              }
            }
          
          Image(uiImage: uiImage)
            .resizable()
            .scaledToFill()
            .frame(width: 160, height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 10))

        }
        
        if title != "" {
          Text(title)
            .font(.caption)
        }
      }
    }
}

#Preview {
  ImageHolder(uiImage: UIImage(systemName: "person.circle")!, title: "Test")
}
