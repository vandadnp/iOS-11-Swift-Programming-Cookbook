//
//  AppDelegate.swift
//  Allowing Users to Enter Text in Response to Local and Remote Notifications
//
//  Created by Vandad on 6/29/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import UIKit
import UserNotifications
import Intents

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,
UNUserNotificationCenterDelegate {
  
  var window: UIWindow?
  
  private var notificationCenter: UNUserNotificationCenter{
    return UNUserNotificationCenter.current()
  }
  
  //the rest of our code will follow here shortly...
  
  func registerForNotifications(){
    
    notificationCenter.delegate = self
    
    notificationCenter.requestAuthorization(options: [.alert]){[weak self]
      (succeeded, error) in
      
      guard let `self` = self else {return}
      
      if let error = error, succeeded == false{
        print("Failed, error = \(error)")
        return
      }
      
      let enterInfo = UNTextInputNotificationAction(identifier: "enter",
                                                    title: "Enter your name",
                                                    options: [.foreground])
      
      let cancel = UNNotificationAction(identifier: "cancel",
                                        title: "Cancel",
                                        options: [])
      
      let category = UNNotificationCategory(
        identifier: "texted",
        actions: [enterInfo, cancel],
        intentIdentifiers: [INSendMessageIntentIdentifier],
        hiddenPreviewsBodyPlaceholder: "Placeholder",
        options: [.hiddenPreviewsShowTitle])
      
      self.notificationCenter.setNotificationCategories([category])
      
    }
    
  }
  
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions
    launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
    
    registerForNotifications()
    
    return true
  }
  
  func scheduleNotification(){
    
    let trigger = UNTimeIntervalNotificationTrigger(
      timeInterval: 3.0, repeats: false)
    
    let content = UNMutableNotificationContent()
    content.body = "Please enter your name now"
    content.categoryIdentifier = "texted"
    
    let request = UNNotificationRequest(
      identifier: UUID().uuidString, content: content, trigger: trigger)
    
    notificationCenter.add(request) {error in
      if let error = error {
        print("Could not schedule notification. Error = \(error)")
      } else {
        print("Successfully scheduled the notification")
      }
    }
    
  }
  
  func applicationDidEnterBackground(_ application: UIApplication) {
    scheduleNotification()
  }
  
  func userNotificationCenter(
    _ center: UNUserNotificationCenter,
    didReceive response: UNNotificationResponse,
    withCompletionHandler completionHandler: @escaping () -> Void) {
    
    guard let response = response as? UNTextInputNotificationResponse,
      response.actionIdentifier == "enter" else {
        completionHandler()
        return
    }
    
    print(response.userText)
    completionHandler()
    
  }
  
}
