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
  var galleryImage: UIImage?
  
  var isInitialized: Bool = false
  
  var faceCaptureResponse: FaceCaptureResponse? {
    didSet {
      // Triggers whenever faceCaptureResponse changes
      faceCaptureResultsReady = faceCaptureResponse != nil
    }
  }
  var faceCaptureResultsReady: Bool = false
  
  var matchFaceResponse: MatchFacesResponse? {
    didSet {
      matchFaceResponseReady = matchFaceResponse != nil
      
      guard let similarity = matchFaceResponse?.results.first?.similarity?.doubleValue else {
        return
      }
      similarityPercentage = Int(similarity * 100)
    }
  }
  var matchFaceResponseReady: Bool = false
  var similarityPercentage: Int = 0
  
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
    
    let uiConfiguration = UIConfiguration {
      $0.setColor(.blue, forItem: .CameraScreenFrontHintLabelText)
      $0.setFont(.systemFont(ofSize: 20.0, weight: .semibold), forItem: .CameraScreenHintLabel)
      $0.setColor(.white, forItem: .CameraScreenFrontHintLabelBackground)
      
      $0.setColor(.blue, forItem: .CameraScreenStrokeActive)
      $0.setColor(.blue, forItem: .CameraScreenStrokeNormal)
      $0.setColor(.blue.withAlphaComponent(0.35), forItem: .CameraScreenSectorTarget)
      $0.setColor(.blue, forItem: .CameraScreenSectorActive)
    }
    
    FaceSDK.service.customization.configuration = uiConfiguration
  }
  
  func showFaceCapture() {
    guard let presenter = UIApplication.shared.rootViewController else {
      return
    }
    
    let configuration = FaceCaptureConfiguration {
      $0.isCameraSwitchButtonEnabled = true
    }
    
    FaceSDK.service.presentFaceCaptureViewController(from: presenter, animated: true, configuration: configuration) { response in
      self.faceCaptureResponse = response
    }
  }
  
  func makeComparison() {
    guard let faceCaptureImage = faceCaptureResponse?.image else {
      return
    }
    guard let photoGalleryImage = galleryImage else {
      return
    }
    
    let images = [
      MatchFacesImage(image: faceCaptureImage.image, imageType: .live),
      MatchFacesImage(image: photoGalleryImage, imageType: .external),
    ]
    
    let request = MatchFacesRequest(images: images)
    
    FaceSDK.service.matchFaces(request, completion: { response in
      self.matchFaceResponse = response
    })
  }
  
  func reset() {
    pickerItem = nil
    galleryImage = nil
    faceCaptureResponse = nil
    faceCaptureResultsReady = false
    matchFaceResponse = nil
    matchFaceResponseReady = false
    similarityPercentage = 0
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
