//
//  AppDelegate.swift
//  Recording and Reading Accelerometer Data
//
//  Created by Vandad on 7/29/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import UIKit
import CoreMotion

extension CMSensorDataList : Sequence{
  public func makeIterator() -> NSFastEnumerationIterator {
    return NSFastEnumerationIterator(self)
  }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  lazy var recorder = CMSensorRecorder()
  
  func example1(){
    
    guard CMSensorRecorder.isAccelerometerRecordingAvailable() else {
      print("Accelerometer data recording is not available")
      return
    }
    
    let duration = 3.0
    recorder.recordAccelerometer(forDuration: duration)
    
    OperationQueue().addOperation{[unowned recorder] in
      
      Thread.sleep(forTimeInterval: duration)
      let now = Date()
      let past = now.addingTimeInterval(-(duration))
      guard let data = recorder.accelerometerData(from: past, to: now) else{
        return
      }
      
      print(data)
      
    }
    
  }
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
    
    example1()
    
    return true
  }
  
}

