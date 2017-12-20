//
//  ViewController.swift
//  Supporting Split Views
//
//  Created by Vandad on 9/13/16.
//  Copyright © 2016 Pixolity. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    
    let newView = UIView()
    newView.backgroundColor = .orange
    newView.translatesAutoresizingMaskIntoConstraints = false
    
    view.addSubview(newView)
    
    newView.leadingAnchor.constraint(equalTo:
      view.leadingAnchor).isActive = true
    
    newView.trailingAnchor.constraint(equalTo:
      view.trailingAnchor).isActive = true
    
    newView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    newView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    
  }

}

