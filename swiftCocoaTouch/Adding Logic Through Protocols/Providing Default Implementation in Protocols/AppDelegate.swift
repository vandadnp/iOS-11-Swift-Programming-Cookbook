//
//  AppDelegate.swift
//  Providing Default Implementation in Protocols
//
//  Created by Vandad NP on 7/4/17.
//  Copyright © 2017 Pixolity Ltd. All rights reserved.
//

import UIKit

protocol HasFullName{
  var firstName: String {get}
  var lastName: String {get}
}

extension HasFullName{
  var fullName: String{
    return "\(firstName) \(lastName)"
  }
}

struct Person: HasFullName{
  let firstName: String
  let lastName: String
}

protocol Fetchable{
  var fetchableUrl: URL? {get}
}

extension Fetchable{
  typealias FetchCompletion = (Either<Data, FetchError>) -> Void
  func fetch(completion: @escaping FetchCompletion){
    //provide your implementation here
  }
}

enum Either<V, E>{
  case value(V)
  case error(E)
}

enum FetchError: Error{
  case noUrlGiven
  case connectionError
}

extension URL: Fetchable{
  var fetchableUrl: URL?{
    return self
  }
}

extension String: Fetchable{
  var fetchableUrl: URL?{
    return URL(string: self)
  }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func example1(){
    
    let fooBar = Person(firstName: "Foo", lastName: "Bar")
    print(fooBar.fullName) // "Foo Bar"
    
  }
  
  func example2(){
    
    URL(string: "https://www.apple.com")?.fetch{either in
      switch either{
      case .value(let data):
        print(data)
      case .error(let error):
        print(error)
      }
    }
    
  }
  
  func example3(){
    
    "https://www.apple.com".fetch {either in
      switch either{
      case .value(let data):
        print(data)
      case .error(let error):
        print(error)
      }
    }
    
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

