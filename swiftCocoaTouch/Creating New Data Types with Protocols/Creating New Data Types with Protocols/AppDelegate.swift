//
//  AppDelegate.swift
//  Creating New Data Types with Protocols
//
//  Created by Vandad NP on 7/2/17.
//  Copyright © 2017 Pixolity Ltd. All rights reserved.
//

import UIKit

protocol Foo{}
protocol Bar{}

protocol HasWheels{
  var wheelCount: Int {get}
}

protocol HasGears{
  var gearCount: Int {get}
}

protocol HasEngine{
  var hoursePower: Int {get}
}

protocol HasVehicle{
  associatedtype Vehicle = HasWheels & HasGears & HasEngine
  var vehicle: Vehicle {get}
}

struct Volvo: HasWheels, HasGears, HasEngine{
  let wheelCount: Int
  let gearCount: Int
  let hoursePower: Int
  
  static var v90: Volvo{
    return Volvo(wheelCount: 4, gearCount: 6, hoursePower: 185)
  }
  
}



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  
  func example1(){
    
    func isFooBar(_ obj: Any){
      if obj is Foo & Bar{
        print("Foo & Bar") // The code will finish here
      } else {
        print("Not Foo & Bar") // This line will not be executed
      }
    }
    
    let someObject = "Foo Bar"
    isFooBar(someObject)
    
  }
  
  func example2(){
    
    struct Person: HasVehicle{
      typealias Vehicle = Volvo
      let vehicle: Vehicle
    }
    
    let fooBar = Person(vehicle: .v90)
    print(fooBar)
    
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

