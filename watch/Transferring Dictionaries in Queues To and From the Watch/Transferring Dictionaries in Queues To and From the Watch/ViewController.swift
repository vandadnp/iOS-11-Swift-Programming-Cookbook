//
//  ViewController.swift
//  Transferring Dictionaries in Queues To and From the Watch
//
//  Created by Vandad on 8/5/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import UIKit
import WatchConnectivity

class ViewController: UIViewController, WCSessionDelegate {
  
  @IBOutlet var statusLbl: UILabel!
  @IBOutlet var sendBtn: UIButton!
  
  var status: String?{
    get{return self.statusLbl.text}
    set{
      DispatchQueue.main.async{
        self.statusLbl.text = newValue
      }
    }
  }
  
  @IBAction func send() {
    
    guard let infoPlist = Bundle.main.infoDictionary else{
      status = "Could not get the Info.plist"
      return
    }
    
    let key = kCFBundleIdentifierKey as String
    
    let plist = [
      key : infoPlist[key] as! String
    ]
    
    let transfer = WCSession.default.transferUserInfo(plist)
    status = transfer.isTransferring ? "Sent" : "Could not send yet"
    
  }
  
  func updateUiForSession(_ session: WCSession){
    status = session.isReachable ? "Ready to send" : "Not reachable"
    sendBtn.isEnabled = session.isReachable
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
  
  func sessionReachabilityDidChange(_ session: WCSession) {
    updateUiForSession(session)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    guard WCSession.isSupported() else{
      return
    }
    
    let session = WCSession.default
    session.delegate = self
    session.activate()
    updateUiForSession(session)
    
  }
  
}

