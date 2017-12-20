//
//  ViewController.swift
//  Providing Vibrational Feedback to Users
//
//  Created by Vandad NP on 5/26/17.
//  Copyright © 2017 Pixolity Ltd. All rights reserved.
//

import UIKit

class ViewController: UIViewController,
UIPickerViewDelegate, UIPickerViewDataSource {
  
  lazy var selectionFeedbackGenerator: UISelectionFeedbackGenerator = {
    return UISelectionFeedbackGenerator()
  }()
  
  let years = Array(1935...2020)
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    
    UIImpactFeedbackGenerator(style: .medium).impactOccurred()
    
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView,
                  numberOfRowsInComponent component: Int) -> Int {
    return years.count
    
  }
  
  func pickerView(_ pickerView: UIPickerView,
                  didSelectRow row: Int, inComponent component: Int) {
    selectionFeedbackGenerator.selectionChanged()
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int,
                  forComponent component: Int) -> String? {
    
    return "\(years[row])"
  }

}

