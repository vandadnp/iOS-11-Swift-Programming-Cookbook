//
//  ImageDocument.swift
//  DocumentApp
//
//  Created by Vandad NP on 7/22/17.
//  Copyright © 2017 Pixolity Ltd. All rights reserved.
//

import UIKit
import MobileCoreServices

func == (lhs: String?, rhs: CFString) -> Bool{
  guard let lhs = lhs else {return false}
  return lhs == rhs as String
}

class ImageDocument: UIDocument {
  
  var imageData: Data?
  
  //the rest of our code will be placed here shortly...
  
  override func load(
    fromContents contents: Any, ofType typeName: String?) throws {
    
    guard typeName == kUTTypePNG else {
      throw ImageDocumentErrors.invalidTypeName(typeName)
    }
    
    guard let data = contents as? Data else {
      throw ImageDocumentErrors.invalidContentType
    }
    
    imageData = data
    
  }
  
  enum ImageDocumentErrors: Error{
    case invalidTypeName(String?)
    case invalidContentType
  }
  
  override func contents(forType typeName: String) throws -> Any {
    
    guard typeName == kUTTypePNG else {
      throw ImageDocumentErrors.invalidTypeName(typeName)
    }
    
    let emptyImageData = self.dataForWhiteScreen
    return imageData ?? emptyImageData
    
  }
  
  private var dataForWhiteScreen: Data{
    
    defer{
      UIGraphicsEndImageContext()
    }
    
    let size = UIScreen.main.bounds.size
    UIGraphicsBeginImageContextWithOptions(size, true, 0.0)
    guard let context = UIGraphicsGetCurrentContext() else {
      return Data()
    }
    UIColor.white.setFill()
    context.fill(CGRect(origin: .zero, size: size))
    guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
      return Data()
    }
    return UIImagePNGRepresentation(image) ?? Data()
  }
  
}
