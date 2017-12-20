//
//  AppDelegate.swift
//  Providing an ETA for Transit Transport Type
//
//  Created by Vandad on 7/4/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import UIKit
import MapKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
func application(_ app: UIApplication,
                 open url: URL,
                 options:
  [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
  
  guard MKDirectionsRequest.isDirectionsRequest(url) else{
    return false
  }
  
  //now we have the url
  let req = MKDirectionsRequest(contentsOf: url)
  
  guard req.source != nil && req.destination != nil else{
    return false
  }
  
  req.transportType = .transit
  req.requestsAlternateRoutes = true
  
  let dir = MKDirections(request: req)
  
  dir.calculateETA {response, error in
    guard let resp = response, error == nil else{
      //handle the error
      print(error!)
      return
    }
    
    print("ETA response = \(resp)")
    
  }
  
  return true
  
}

  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
    // Override point for customization after application launch.
    return true
  }
  
  
}

