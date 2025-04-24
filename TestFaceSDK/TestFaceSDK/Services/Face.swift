//
//  FaceSDK.swift
//  TestFaceSDK
//
//  Created by Rodrigo Llaguno on 21/04/25.
//

import Foundation
import FaceSDK
import SwiftUI
import PhotosUI

@Observable
class Face {
  var currentNavigation: NavigationIndex = .instructions
  var isInitialized: Bool = false

  //Gallery Image variables
  var pickerItem: PhotosPickerItem?
  var galleryImage: UIImage?
  
  //Face Capture Image Variables
  var faceCaptureResultsReady: Bool = false
  var faceCaptureResponse: FaceCaptureResponse? {
    didSet {
      // Triggers whenever faceCaptureResponse changes
      faceCaptureResultsReady = faceCaptureResponse != nil
    }
  }
  
  //Match Face Variables
  var similarityPercentage: Int = 0
  var matchFaceResponseReady: Bool = false
  var matchFaceResponse: MatchFacesResponse? {
    didSet {
      withAnimation(.easeOut(duration: 1.5)) {
        matchFaceResponseReady = matchFaceResponse != nil
      }
      
      guard let similarity = matchFaceResponse?.results.first?.similarity?.doubleValue else {
        return
      }
      similarityPercentage = Int(similarity * 100)
    }
  }
  
  func initialize() {
    FaceSDK.service.initialize() { [weak self] success, error in
        if success {
            self?.isInitialized = true
        } else if let error = error {
            print(error.localizedDescription)
        }
    }
    
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
  
  func deinitialize() {
    FaceSDK.service.deinitialize()
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
