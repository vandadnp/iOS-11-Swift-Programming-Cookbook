//
//  ViewController.swift
//  Customizing the Map View with System Buttons
//
//  Created by Vandad NP on 7/12/17.
//  Copyright © 2017 Pixolity Ltd. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
  
  @IBOutlet weak var mapView: MKMapView!
  
  var trackingButton: UIBarButtonItem{
    let button = MKUserTrackingButton(mapView: self.mapView)
    return UIBarButtonItem(customView: button)
  }
  
  var compassButton: UIBarButtonItem{
    let button = MKCompassButton(mapView: self.mapView)
    button.compassVisibility = .visible
    return UIBarButtonItem(customView: button)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    mapView.mapType = .mutedStandard
    mapView.showsCompass = false
    navigationItem.rightBarButtonItem = trackingButton
    navigationItem.leftBarButtonItem = compassButton
    
  }
  
}

