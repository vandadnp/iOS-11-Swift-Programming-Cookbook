//
//  ViewController.swift
//  Adjusting Labels while Supporting Dynamic Types
//
//  Created by Vandad NP on 7/11/17.
//  Copyright © 2017 Pixolity Ltd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak private var titleLabel: UILabel!
  @IBOutlet weak private var descriptionLabel: UILabel!
  
  //the rest of our code will be placed here...
  
  func readjustFonts(){
    
    let defaultTitleFont = UIFont.systemFont(ofSize: 20)
    
    titleLabel.font = UIFontMetrics(forTextStyle: .title1)
      .scaledFont(for: defaultTitleFont, compatibleWith: traitCollection)
    
    let defaultDescriptionFont = UIFont.systemFont(ofSize: 17)
    descriptionLabel.font = UIFontMetrics(forTextStyle: .body)
      .scaledFont(for: defaultDescriptionFont, compatibleWith: traitCollection)
    
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    readjustFonts()
    
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(respondToSizeCategoryChangedNotification(_:)),
      name: .UIContentSizeCategoryDidChange,
      object: nil)
    
  }
  
  @objc func respondToSizeCategoryChangedNotification(
    _ notification: NSNotification){
    
    readjustFonts()
    
  }
  
}

