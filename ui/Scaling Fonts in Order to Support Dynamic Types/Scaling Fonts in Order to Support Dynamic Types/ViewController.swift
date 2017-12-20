//
//  ViewController.swift
//  Scaling Fonts in Order to Support Dynamic Types
//
//  Created by Vandad NP on 7/10/17.
//  Copyright © 2017 Pixolity Ltd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var label: UILabel!
  
  var originalFont: UIFont{
    let defaultSize = CGFloat(40.0)
    return UIFont(name: "Champignon", size: defaultSize) ??
      UIFont.systemFont(ofSize: defaultSize)
  }
  
  func readjustLabelFontSize(){
    label.font = UIFontMetrics.default.scaledFont(
      for: originalFont, compatibleWith: traitCollection)
    
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    readjustLabelFontSize()
    
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(respondToSizeCategoryChangedNotification(_:)),
      name: .UIContentSizeCategoryDidChange,
      object: nil)
    
  }
  
  @objc func respondToSizeCategoryChangedNotification(
    _ notification: NSNotification){
    
    readjustLabelFontSize()
    
  }
  
}

