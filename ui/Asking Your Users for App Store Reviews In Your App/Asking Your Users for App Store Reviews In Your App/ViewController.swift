//
//  ViewController.swift
//  Asking Your Users for App Store Reviews In Your App
//
//  Created by Vandad NP on 3/21/17.
//  Copyright © 2017 Pixolity Ltd. All rights reserved.
//

import UIKit
import StoreKit

class ViewController: UIViewController {
  
  @IBAction func leaveAReview(_ sender: Any) {
    SKStoreReviewController.requestReview()
  }
  
}

