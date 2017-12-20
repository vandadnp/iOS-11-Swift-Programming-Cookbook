//
//  AppDelegate.swift
//  Noticing Changes in Pairing State Between the iOS and Watch Apps
//
//  Created by Vandad on 8/4/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import UIKit
import WatchConnectivity

extension WCSession{
  public func printInfo(){
    
    //paired
    print("Paired: ", terminator: "")
    print(self.isPaired ? "Yes" : "No")
    
    //watch app installed
    print("Watch app installed: ", terminator: "")
    print(self.isWatchAppInstalled ? "Yes" : "No")
    
    //complication enabled
    print("Complication enabled: ", terminator: "")
    print(self.isComplicationEnabled ? "Yes" : "No")
    
    
    if let watchDirectoryURL = self.watchDirectoryURL{
      //watch directory
      print("Watch directory url", terminator: "")
      print(watchDirectoryURL)
    }
    
  }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, WCSessionDelegate {
  
  var window: UIWindow?
  
  func sessionReachabilityDidChange(_ session: WCSession) {
    print("Reachable: ",  terminator: "")
    print(session.isReachable ? "Yes" : "No")
  }
  
  func sessionWatchStateDidChange(_ session: WCSession) {
    print("Watch state is changed")
    session.printInfo()
  }
  
  func session(
    _ session: WCSession,
    activationDidCompleteWith activationState: WCSessionActivationState,
    error: Error?) {
    //empty for now
  }
  
  func sessionDidBecomeInactive(_ session: WCSession) {
    //empty for now
  }
  
  func sessionDidDeactivate(_ session: WCSession) {
    //empty for now
  }
  
  func example1(){
    guard WCSession.isSupported() else {
      print("Session is not supported")
      return
    }
    
    let session = WCSession.default
    session.delegate = self
    session.activate()
  }
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
    // Override point for customization after application launch.
    example1()
    return true
  }
  
}

