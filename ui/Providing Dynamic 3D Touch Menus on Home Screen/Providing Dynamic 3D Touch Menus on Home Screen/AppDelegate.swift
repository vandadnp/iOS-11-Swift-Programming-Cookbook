//
//  AppDelegate.swift
//  Providing Dynamic 3D Touch Menus on Home Screen
//
//  Created by Vandad NP on 3/21/17.
//  Copyright © 2017 Pixolity Ltd. All rights reserved.
//

import UIKit

extension UIApplicationShortcutItem{
  static var books: UIApplicationShortcutItem{
    return UIApplicationShortcutItem(type: "book", localizedTitle: "Books")
  }
  static var magazines: UIApplicationShortcutItem{
    return UIApplicationShortcutItem(type: "mag", localizedTitle: "Magazines")
  }
  static var comics: UIApplicationShortcutItem{
    return UIApplicationShortcutItem(type: "com", localizedTitle: "Comics")
  }
}

func == (lhs: UIApplicationShortcutItem,
         rhs: UIApplicationShortcutItem) -> Bool{
  return lhs.hashValue == rhs.hashValue
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions
    launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    application.shortcutItems = [.books, .magazines, .comics]
    
    return true
  }
  
  func application(_ application: UIApplication,
                   performActionFor shortcutItem: UIApplicationShortcutItem,
                   completionHandler: @escaping (Bool) -> Void) {
    
    if shortcutItem == .books{
      print("Books is selected")
      completionHandler(true)
    } else if shortcutItem == .magazines{
      print("Magazines is selected")
      completionHandler(true)
    } else if shortcutItem == .comics{
      print("Comics is selected")
      completionHandler(true)
    } else {
      //unhandled
      completionHandler(false)
    }
    
  }
  
}

