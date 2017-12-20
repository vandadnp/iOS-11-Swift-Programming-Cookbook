//
//  AppDelegate.swift
//  Organizing Private Functions and Properties With Extensions
//
//  Created by Vandad NP on 5/17/17.
//  Copyright © 2017 Pixolity Ltd. All rights reserved.
//

import UIKit

private extension Person{
  //private var can access public "name" property
  private var firstName: String?{
    return name.components(separatedBy: " ").first
  }
}

private extension Person{
  //private var can access public "name" property
  private var lastName: String?{
    let components = name.components(separatedBy: " ")
    guard components.count >= 2 else {return nil}
    return components.last
  }
}

private extension Person{
  //private var can access private "firstName" property
  //as long as both are defined in the same file
  private var hasValidFirstName: Bool{
    return (firstName ?? "").characters.count >= 2
  }
}

private extension Person{
  //private var can access private "lastName" property
  //since both are defined in the same file
  private var hasValidLastName: Bool{
    return (lastName ?? "").characters.count >= 3
  }
}

extension Person{
  //public var can access private "hasValidFirstName" and
  //"hasValidLastName" properties since it is defined in the same file
  var hasValidName: Bool{
    return hasValidFirstName && hasValidLastName
  }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func example1(){
    
    let fooBar = Person(name: "Foo Bar", age: 22)
    print("Foo bar valid name? = \(fooBar.hasValidName)")
    
  }
  
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    example1()
    return true
  }
  
  func applicationWillResignActive(_ application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
  }
  
  func applicationDidEnterBackground(_ application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }
  
  func applicationWillEnterForeground(_ application: UIApplication) {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
  }
  
  func applicationDidBecomeActive(_ application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }
  
  func applicationWillTerminate(_ application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }
  
  
}

