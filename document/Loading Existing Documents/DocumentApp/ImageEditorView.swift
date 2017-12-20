//
//  ImageEditorView.swift
//  DocumentApp
//
//  Created by Vandad NP on 7/20/17.
//  Copyright © 2017 Pixolity Ltd. All rights reserved.
//

import UIKit

protocol ImageEditorViewDelegate: class{
  func imageEditorView(view: ImageEditorView, hasDataForImage data: Data)
}

fileprivate extension CGRect{
  init(center: CGPoint, radius: CGFloat){
    self = CGRect(origin: CGPoint(x: center.x - radius, y: center.y - radius),
                  size: CGSize(width: radius * 2, height: radius * 2))
  }
}

class ImageEditorView: UIView {
  
  private weak var delegate: ImageEditorViewDelegate?
  private var touchPoints = [CGPoint]()
  
public var backgroundData: Data?{
  didSet{
    guard backgroundData != nil else {return}
    setNeedsDisplay()
  }
}
  
  init(delegate: ImageEditorViewDelegate) {
    super.init(frame: .zero)
    self.delegate = delegate
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  func draw(touches: Set<UITouch>){
    guard let touchPoint = touches.first?.location(in: self) else {return}
    touchPoints.append(touchPoint)
    setNeedsDisplay()
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)
    draw(touches: touches)
  }
  
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesMoved(touches, with: event)
    draw(touches: touches)
  }
  
  override func draw(_ rect: CGRect) {
    guard let context = UIGraphicsGetCurrentContext() else {return}
    
    //background color
    UIColor.white.setFill()
    context.fill(rect)
    
    //then we draw the background if there is some
    if let backgroundData = backgroundData,
      let image = UIImage(data: backgroundData){
      
      let imageWidth = bounds.width
      let imageHeight = (image.size.height * imageWidth) / image.size.width
      let x = center.x - (imageWidth / 2.0)
      let y = center.y - (imageHeight / 2.0)
      let rect = CGRect(x: x, y: y, width: imageWidth, height: imageHeight)
      image.draw(in: rect)
    }
    
    //draw the touch points
    touchPoints.forEach{point in
      UIColor.black.setFill()
      let ellipseRect = CGRect(center: point, radius: 10.0)
      context.fillEllipse(in: ellipseRect)
    }
    
  }
  
  var imageData: Data?{
    
    UIGraphicsBeginImageContext(bounds.size)
    
    defer{UIGraphicsEndImageContext()}
    
    guard drawHierarchy(in: bounds, afterScreenUpdates: true) else {return nil}
    
    guard let image = UIGraphicsGetImageFromCurrentImageContext()
      else {return nil}
    
    return UIImagePNGRepresentation(image)
    
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesEnded(touches, with: event)
    guard let data = imageData else {return}
    
    delegate?.imageEditorView(view: self, hasDataForImage: data)
  }
  
}
