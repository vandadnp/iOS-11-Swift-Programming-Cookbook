//
//  ViewController.swift
//  Communicating Interactively Between iOS and Watch OS
//
//  Created by Vandad on 8/5/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import UIKit
import WatchConnectivity
import SharedCode

class ViewController: UIViewController, WCSessionDelegate {
  
  @IBOutlet var sendBtn: UIBarButtonItem!
  @IBOutlet var textField: UITextField!
  @IBOutlet var watchStatusLbl: UILabel!
  @IBOutlet var watchReplyLbl: UILabel!
  
  var watchStatus: String{
    get{return self.watchStatusLbl.text ?? ""}
    set{onMainThread{self.watchStatusLbl.text = newValue}}
  }
  
  var watchReply: String{
    get{return self.watchReplyLbl.text ?? ""}
    set{onMainThread{self.watchReplyLbl.text = newValue}}
  }
  
  @IBAction func send(_ sender: AnyObject) {
    
    guard let txt = textField.text, txt.characters.count > 0 else{
      textField.placeholder = "Enter some text here first"
      return
    }
    
    WCSession.default.sendMessage(["msg" : txt],
                                    replyHandler: {dict in
                                      
                                      guard dict["msg"] is String &&
                                        dict["msg"] as! String == "delivered" else{
                                          self.watchReply = "Could not deliver the message"
                                          return
                                      }
                                      
                                      self.watchReply = dict["msg"] as! String
                                      
    }){err in
      self.watchReply = "An error happened in sending the message"
    }
    
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
  
  func session(_ session: WCSession,
               didReceiveMessage message: [String : Any]) {
    
    guard let msg = message["msg"] as? Int,
      let value = PredefinedMessage(rawValue: msg) else{
        watchReply = "Received invalid message"
        return
    }
    
    switch value{
    case .hello:
      watchReply = "Hello"
    case .howAreYou:
      watchReply = "How are you?"
    case .iHearYou:
      watchReply = "I hear you"
    case .thankYou:
      watchReply = "Thank you"
    }
    
  }
  
  func updateUiForSession(_ session: WCSession){
    watchStatus = session.isReachable ? "Reachable" : "Not reachable"
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

