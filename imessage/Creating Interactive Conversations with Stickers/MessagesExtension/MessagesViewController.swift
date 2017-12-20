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

extension CGSize{
  var rectWithZeroOrigin: CGRect{
    return CGRect(origin: .zero, size: self)
  }
}

extension URL{
  //counts the number of path components in the url
  var pathCount: Int{
    let components = NSURLComponents(url: self, resolvingAgainstBaseURL: false)
    return components?.path?
      .components(separatedBy: "/")
      .filter{$0.characters.count > 0}
      .count ?? 0
  }
}

class MessagesViewController : MSMessagesAppViewController,
StickersViewControllerDelegate {
  
  func loadViewController
    (_ forPresentationStyle: MSMessagesAppPresentationStyle) -> Bool{
    
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
  
  var messageImage: UIImage? {
    guard let image = UIImage(named: "Accounts") else {return nil}
    let rect = image.size.rectWithZeroOrigin
    
    let renderer = UIGraphicsImageRenderer(bounds: rect)
    return renderer.image {context in
      let bgColor: UIColor = .black
      bgColor.setFill()
      context.fill(rect)
      image.draw(at: .zero)
    }
  }
  
  func plusButtonTappedOn(_ controller: UIViewController) {
    
    let paths = [
      "library/", "prerelease/", "ios/",
      "releasenotes/", "General/", "WhatsNewIniOS/"
    ]
    
    let base = "developer.apple.com/"
    
    guard let conversation = activeConversation else {fatalError()}
    let session = conversation.selectedMessage?.session ?? MSSession()
    
    let url: URL
    let caption: String?
    if let selectedMessageUrl = conversation.selectedMessage?.url{
      let pathCount = selectedMessageUrl.pathCount
      if pathCount < paths.count{
        let lastPath = paths[pathCount]
        url = selectedMessageUrl.appendingPathComponent(lastPath)
        caption = "\(base) (\(lastPath))"
      } else if let lastPath = paths.last {
        url = selectedMessageUrl
        caption = "\(base) (\(lastPath))"
      } else {
        return
      }
    } else {
      url = URL(string: "https://\(base)")!
      caption = base
    }
    
    let message = MSMessage(session: session)
    
    let layout = MSMessageTemplateLayout()
    layout.image = messageImage
    layout.caption = caption
    
    message.layout = layout
    message.url = url
    
    conversation.insert(message) {[weak self]error in
      guard let strongSelf = self else {return}
      strongSelf.dismiss()
    }
    
  }
  
  override func willBecomeActive(with conversation: MSConversation) {
    // Called when the extension is about to move from the
    // inactive to active state.
    // This will happen when the extension is about to present UI.
    
    // Use this method to configure the extension and restore previously
    // stored state.
    
    let _ = loadViewController(.compact)
    
  }
  
  override func willTransition(to presentationStyle:
    MSMessagesAppPresentationStyle) {
    // Called before the extension transitions to a new presentation style.
    
    // Use this method to prepare for the change in presentation style.
    let _ = loadViewController(.compact)
  }
  
  override func didTransition(to presentationStyle:
    MSMessagesAppPresentationStyle) {
    // Called after the extension transitions to a new presentation style.
    
    // Use this method to finalize any behaviors associated with the
    // change in presentation style.
    let _ = loadViewController(presentationStyle)
  }
  
}
