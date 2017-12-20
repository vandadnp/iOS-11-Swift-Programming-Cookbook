//
//  MyView.swift
//  SnapshotTesting
//
//  Created by Vandad NP on 5/10/17.
//  Copyright © 2017 Pixolity Ltd. All rights reserved.
//

import UIKit

class MyView: UIView {
  
  override func draw(_ rect: CGRect) {
    
    guard let context = UIGraphicsGetCurrentContext() else {return}
    
    let backgroundColor = UIColor.black.cgColor
    
    context.setFillColor(backgroundColor)
    context.fill(rect)
    
    let middleRect = rect
      .applying(CGAffineTransform(scaleX: 0.5, y: 0.5))
      .applying(CGAffineTransform(translationX: rect.width / 4.0,
                                  y: rect.height / 4.0))
    
    context.addEllipse(in: middleRect)
    let circleColor = UIColor.red.withAlphaComponent(0.9).cgColor
    context.setFillColor(circleColor)
    context.fillPath()
    
  }
  
}
