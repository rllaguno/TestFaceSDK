//
//  InstructionData.swift
//  TestFaceSDK
//
//  Created by Rodrigo Llaguno on 21/04/25.
//

import Foundation

enum Instruction: Int {
  case capture = 0
  case select
  case compare
  
  var title: String {
    switch self {
    case .capture: return "Captura facial con FaceSDK"
    case .select: return "Selecciona imagen de galería"
    case .compare: return "Compara ambas imágenes"
    }
  }
  
  var description: String {
    switch self {
    case .capture: return "Captura una foto de tu rostro utilizando el SDK de Regula"
    case .select: return "Selecciona una foto de tu galería donde salga tu rostro"
    case .compare: return "Se realizará una comparación de similitud de ambas imágenes"
    }
  }
  
  var image: String {
    switch self {
    case .capture: return "camera"
    case .select: return "photo.on.rectangle.angled.fill"
    case .compare: return "magnifyingglass"
    }
  }
}
