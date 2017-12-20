//
//  AppDelegate.swift
//  Extending Typed Arrays
//
//  Created by Vandad NP on 5/15/17.
//  Copyright © 2017 Pixolity Ltd. All rights reserved.
//

import UIKit

extension Array where Element == Int{
  
  var largestInteger: Element?{
    return sorted().last
  }
  
}

struct Person{
  let name: String
  let age: Int
}

extension Array where Element == Person{
  var youngest: Element?{
    return sorted(by: {$0.age < $1.age}).first
  }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  let persons = [
    Person(name: "Foo", age: 22),
    Person(name: "Bar", age: 30),
    Person(name: "Baz", age: 19)
  ]
  
  func example1(){
    
    let numbers = [10, 20, 1, 4, 9]
    print(numbers.largestInteger ?? 0)
    
  }
  
  func example2(){
    
    if let youngestPerson = persons.sorted(by: {$0.age < $1.age}).first{
      print("Youngest person = \(youngestPerson)")
    }
    
  }
  
  func example3(){
    
    if let youngestPerson = persons.youngest{
      print("Youngest person = \(youngestPerson)")
    }
    
  }
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    
    example1()
    example2()
    example3()
    
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

