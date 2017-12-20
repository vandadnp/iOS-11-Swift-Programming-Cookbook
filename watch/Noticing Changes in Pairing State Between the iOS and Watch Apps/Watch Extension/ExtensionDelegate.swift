//
//  ExtensionDelegate.swift
//  Watch Extension
//
//  Created by Vandad on 8/4/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import WatchKit
import WatchConnectivity

class ExtensionDelegate: NSObject, WKExtensionDelegate, WCSessionDelegate {
  
  func session(
    _ session: WCSession,
    activationDidCompleteWith activationState: WCSessionActivationState,
    error: Error?) {
    //empty for now
  }
  
  func sessionReachabilityDidChange(_ session: WCSession) {
    print("Reachablity changed. Reachable?", terminator: "")
    print(session.isReachable ? "Yes" : "No")
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
  
  func applicationDidFinishLaunching() {
    example1()
  }
  
}
