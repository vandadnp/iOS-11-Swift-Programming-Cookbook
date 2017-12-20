//
//  ViewController.swift
//  Animating Views
//
//  Created by Vandad on 8/24/16.
//  Copyright © 2016 Pixolity. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet var animatingView: UIView!
  
  let colors: [UIColor] = [
    .red,
    .blue,
    .yellow,
    .orange,
    .green,
    .brown
  ]
  
  func randomColor(notEqualTo currentColor: UIColor) -> UIColor{
    
    var foundColor = currentColor
    
    repeat{
      let index = Int(arc4random_uniform(UInt32(colors.count)))
      foundColor = colors[index]
    } while foundColor.isEqual(currentColor)
    
    return foundColor
    
  }
  
  @IBAction func animatingViewTapped(_ sender: AnyObject) {
    
    let animator = UIViewPropertyAnimator(duration: 1.0, curve: .easeIn){
      [weak animatingView, weak self] in
      
      guard
        let view = animatingView,
        let strongSelf = self,
        let viewBackgroundColor = view.backgroundColor
        else {return}
      
      view.backgroundColor = strongSelf.randomColor(
        notEqualTo: viewBackgroundColor)
      
    }
    
    animator.startAnimation()
    
  }
  
}

