//
//  ImageViewController.swift
//  Animating Details with Peek and Pop
//
//  Created by Vandad NP on 3/6/17.
//  Copyright © 2017 Pixolity Ltd. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
  
  @IBOutlet weak private var imageView: UIImageView!
  
  public var image: UIImage? = nil
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    imageView.image = image
  }
  
}
