//
//  FaceSDK.swift
//  TestFaceSDK
//
//  Created by Rodrigo Llaguno on 21/04/25.
//

import Foundation
import Combine
import FaceSDK
import SwiftUI
import PhotosUI

@Observable
class Face {
  var currentNavigation: NavigationIndex = .instructions
  
  var pickerItem: PhotosPickerItem?
  var galleryImage: SwiftUICore.Image?
  
  var isInitialized: Bool = false
  
  var faceCaptureResponse: FaceCaptureResponse? {
    didSet {
      // Triggers whenever faceCaptureResponse changes
      faceCaptureResultsReady = faceCaptureResponse != nil
    }
  }
  var faceCaptureResultsReady: Bool = false
  
  private var cancellables: Set<AnyCancellable> = .init()
  
  init() {
    setup()
  }
  
  func setup() {
    FaceSDK.service.initializeFace().sink { [unowned self] completion in
      switch completion {
      case .finished:
        self.isInitialized = true
      case .failure(let error):
        print(error.localizedDescription)
      }
    } receiveValue: { _ in
      
    }.store(in: &cancellables)
  }
  
  func showFaceCapture() {
    guard let presenter = UIApplication.shared.rootViewController else {
      return
    }
    
    FaceSDK.service.presentFaceCaptureViewController(from: presenter, animated: true) { response in
      self.faceCaptureResponse = response
    }
  }
  
}

extension FaceSDK {
  func initializeFace() -> AnyPublisher<Bool, Error> {
    Deferred {
      Future<Bool, Error> { promise in
        FaceSDK.service.initialize() { success, error in
          if let error = error {
            promise(.failure(error))
          } else {
            promise(.success(success))
          }
        }
      }
    }.eraseToAnyPublisher()
  }
}
