//
//  AppDelegate.swift
//  Defining Constraints on Protocols
//
//  Created by Vandad NP on 7/4/17.
//  Copyright © 2017 Pixolity Ltd. All rights reserved.
//

import UIKit

protocol Vehicle{
  var wheelCount: Int {get}
}

protocol HeavyVehicle: Vehicle{
  func tankWithDiesel(liters: Int)
}

protocol LightVehicle: Vehicle{
  func tankWithPetrol(liters: Int)
}

protocol OwnsVehicle{
  associatedtype VehicleType: Vehicle
  var vehicle: VehicleType {get}
}

extension OwnsVehicle where VehicleType: HeavyVehicle{
  func fillVehicleTankWithDiesel(){
    //we don't have to implement this now!
  }
}

struct VolvoV90: LightVehicle{
  let wheelCount = 4
  func tankWithPetrol(liters: Int) {
    //we don't have to implement this now!
  }
}

struct Van: HeavyVehicle{
  let wheelCount = 4
  func tankWithDiesel(liters: Int) {
    //we don't have to implement this now!
  }
}


struct PersonWithLightVehicle: OwnsVehicle{
  typealias VehicleType = VolvoV90
  let vehicle = VolvoV90()
}

struct PersonWithHeavyVehicle: OwnsVehicle{
  typealias VehicleType = Van
  let vehicle = Van()
}


let foo = PersonWithLightVehicle()
//foo doesn't have the fillVehicleTankWithDiesel() function

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func example1(){
    let bar = PersonWithHeavyVehicle()
    bar.fillVehicleTankWithDiesel()
  }
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
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

