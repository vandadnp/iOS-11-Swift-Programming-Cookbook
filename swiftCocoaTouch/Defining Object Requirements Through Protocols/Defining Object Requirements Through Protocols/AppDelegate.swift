//
//  AppDelegate.swift
//  Defining Object Requirements Through Protocols
//
//  Created by Vandad NP on 5/30/17.
//  Copyright © 2017 Pixolity Ltd. All rights reserved.
//

import UIKit

enum Either<V, E: Error>{
  case value(V)
  case error(E)
}

protocol Fetchable{
  var fetchUrl: URL? {get}
}

enum FetchError: Error{
  case nilUrl
  case connectionError(Error)
  case emptyData
}

extension Fetchable{
  
  func fetch(completion: @escaping (Either<Data, FetchError>) -> Void){
    
    guard let url = fetchUrl else {
      completion(.error(.nilUrl))
      return
    }
    
    //code the function here
    
  }
  
}

extension String: Fetchable{
  var fetchUrl: URL?{
    return URL(string: self)
  }
}

extension URL: Fetchable{
  var fetchUrl: URL?{
    return self
  }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func example1(){
    
    
    enum FetchError: Error{
      case nilUrl
      case connectionError(Error)
      case emptyData
    }
    
    func fetch(url: URL?,
               completion: @escaping (Either<Data, FetchError>) -> Void){
      
      guard let url = url else {
        completion(.error(.nilUrl))
        return
      }
      
      //code the function here
      
    }
    
  }
  
  func example2(){
    
    
    "https://apple.com".fetch {either in
      switch either{
      case .error(let err):
        print(err)
      case .value(let data):
        print(data)
      }
    }
    
URL(string: "https://apple.com")?.fetch{either in
  switch either{
  case .error(let err):
    print(err)
  case .value(let data):
    print(data)
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

