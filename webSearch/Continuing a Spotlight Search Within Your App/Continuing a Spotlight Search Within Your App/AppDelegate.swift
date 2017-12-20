//
//  AppDelegate.swift
//  Continuing a Spotlight Search Within Your App
//
//  Created by Vandad NP on 3/24/17.
//  Copyright © 2017 Pixolity Ltd. All rights reserved.
//

import UIKit
import CoreSpotlight
import MobileCoreServices

fileprivate extension String{
  static var CSQueryContinuationActionType: String{
    return "CSQueryContinuationActionType"
  }
  static var CSSearchQueryString: String{
    return "kCSSearchQueryString"
  }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func indexItems(){
    
    CSSearchableIndex.default().deleteAllSearchableItems {error in
      
      guard error == nil else {
        print("Error happened while deleting the index")
        return
      }
      
      let attributes =
        CSSearchableItemAttributeSet(itemContentType: kUTTypeImage as String)
      attributes.title = "Foo Bar"
      attributes.contentDescription = "Just some description"
      attributes.keywords = ["foo", "bar"]
      
      let item = CSSearchableItem(uniqueIdentifier: "foobar",
                                  domainIdentifier: "se.pixolity",
                                  attributeSet: attributes)
      
      CSSearchableIndex.default().indexSearchableItems([item]){error in
        if let error = error {
          print("Failed to index the item \(error)")
        } else {
          print("Indexed the item successefully")
        }
      }
      
    }
    
  }
  
  func application(
    _ application: UIApplication,
    willContinueUserActivityWithType userActivityType: String) -> Bool {
    
    if userActivityType == .CSQueryContinuationActionType{
      return true
    } else {
      return false
    }
    
  }
  
  func application(_ application: UIApplication,
                   continue userActivity: NSUserActivity,
                   restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
    
    guard let query =
      userActivity.userInfo?[String.CSSearchQueryString] as? String,
      query.characters.count > 0 else {
        return false
    }
    
    print("The query is \(query)")
    return true
    
  }
  
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions
    launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    indexItems()
    
    return true
  }
  
}

