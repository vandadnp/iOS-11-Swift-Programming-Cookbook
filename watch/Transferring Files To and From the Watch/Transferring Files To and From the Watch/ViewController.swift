//
//  ViewController.swift
//  Transferring Files To and From the Watch
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
  
  func sessionDidBecomeInactive(_ session: WCSession) {
    //empty for now
  }
  
  func sessionDidDeactivate(_ session: WCSession) {
    //empty for now
  }
  
  func session(
    _ session: WCSession,
    activationDidCompleteWith activationState: WCSessionActivationState,
    error: Error?) {
    //empty for now
  }
  
  func session(_ session: WCSession,
               didFinish fileTransfer: WCSessionFileTransfer,
               error: Error?) {
    
    guard error == nil else{
      status = "Error in transferring"
      return
    }
    
    status = "Successfully sent the file"
    
  }
  
  @IBAction func send() {
    
    let fileName = "file.txt"
    
    let fm = FileManager()
    
    let url = try! fm.url(for: .cachesDirectory,
                          in: .userDomainMask, appropriateFor: nil,
                          create: true).appendingPathComponent(fileName)
    
    let text = "Foo Bar"
    
    do{
      try text.write(to: url, atomically: true,
                     encoding: String.Encoding.utf8)
    } catch {
      status = "Could not write the file"
      return
    }
    
    let metadata = ["fileName" : fileName]
    WCSession.default.transferFile(url, metadata: metadata)
    
  }
  
  func updateUiForSession(_ session: WCSession){
    status = session.isReachable ? "Ready to send" : "Not reachable"
    sendBtn.isEnabled = session.isReachable
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

