//
//  MessagesViewController.swift
//  MessageExtension
//
//  Created by Vandad on 7/25/16.
//  Copyright © 2016 Pixolity. All rights reserved.
//

import UIKit
import Messages

struct Identifiers{
  static let StickersViewController = "StickersViewController"
  static let ExpandedStickersViewController = "ExpandedStickersViewController"
}

extension UIViewController{
  func addTo(appViewController host: MSMessagesAppViewController){
    
    //see if this view controller has a delagete and then set it to
    //the host view controller if yes
    if
      let delegate = host as? StickersViewControllerDelegate,
      let vc = self as? HasStickersDelegate{
      vc.delegate = delegate
    }
    
    willMove(toParentViewController: host)
    host.addChildViewController(self)
    view.frame = host.view.bounds
    view.translatesAutoresizingMaskIntoConstraints = false
    host.view.addSubview(view)
    view.leftAnchor.constraint(equalTo: host.view.leftAnchor).isActive = true
    view.rightAnchor.constraint(equalTo: host.view.rightAnchor).isActive = true
    view.topAnchor.constraint(equalTo: host.view.topAnchor).isActive = true
    view.bottomAnchor.constraint(equalTo:
      host.view.bottomAnchor).isActive = true
    didMove(toParentViewController: host)
    
  }
}

class MessagesViewController : MSMessagesAppViewController,
StickersViewControllerDelegate {
  
  func loadViewController
    (forPresentationStyle: MSMessagesAppPresentationStyle) -> Bool{
    
    childViewControllers.forEach{
      $0.willMove(toParentViewController: nil)
      $0.view.removeFromSuperview()
      $0.removeFromParentViewController()
      ($0 as? HasStickersDelegate)?.delegate = nil
    }
    
    let vcId: String
    
    switch presentationStyle{
    case .compact:
      vcId = Identifiers.StickersViewController
    case .expanded:
      vcId = Identifiers.ExpandedStickersViewController
    case .transcript:
      return false
    }
    
    guard let vc = storyboard?
      .instantiateViewController(withIdentifier: vcId) else {return false}
    
    vc.addTo(appViewController: self)
    
    return true
    
  }
  
  func plusButtonTappedOn(controller: UIViewController) {
    let _ = loadViewController(forPresentationStyle: .expanded)
    requestPresentationStyle(.expanded)
  }
  
  override func willBecomeActive(with conversation: MSConversation) {
    // Called when the extension is about to move from the
    // inactive to active state.
    // This will happen when the extension is about to present UI.
    
    // Use this method to configure the extension and restore previously
    // stored state.
    
    let _ = loadViewController(forPresentationStyle: .compact)
    
  }
  
  override func willTransition(to presentationStyle:
    MSMessagesAppPresentationStyle) {
    // Called before the extension transitions to a new presentation style.
    
    // Use this method to prepare for the change in presentation style.
    let _ = loadViewController(forPresentationStyle: presentationStyle)
  }
  
  override func didTransition(to presentationStyle:
    MSMessagesAppPresentationStyle) {
    // Called after the extension transitions to a new presentation style.
    
    // Use this method to finalize any behaviors associated with the
    // change in presentation style.
    let _ = loadViewController(forPresentationStyle: presentationStyle)
  }
  
}
