//
//  AppDelegate.swift
//  Supporting File Browsing in Your App
//
//  Created by Vandad NP on 7/14/17.
//  Copyright © 2017 Pixolity Ltd. All rights reserved.
//

import UIKit

fileprivate extension Array where Element == String{
  static var fileTypes: [Element]{
    return ["public.png", "public.jpeg"]
  }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,
UIDocumentBrowserViewControllerDelegate {
  
  var window: UIWindow?
  
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions:
    [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    let browser = UIDocumentBrowserViewController(
      forOpeningFilesWithContentTypes: .fileTypes)
    
    browser.delegate = self
    window?.rootViewController = browser
    
    return true
    
  }
  
  func documentBrowser(
    _ controller: UIDocumentBrowserViewController,
    didRequestDocumentCreationWithHandler importHandler:
    @escaping (URL?, UIDocumentBrowserViewController.ImportMode) -> Void) {
    
  }
  
}

