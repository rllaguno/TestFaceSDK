//
//  ComparisonView.swift
//  TestFaceSDK
//
//  Created by Rodrigo Llaguno on 22/04/25.
//

import SwiftUI

struct ComparisonView: View {
  @Binding var face: Face
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
  ComparisonView(face: .constant(Face()))
}
