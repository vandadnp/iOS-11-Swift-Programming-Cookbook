//
//  AppDelegate.swift
//  Handling Corner Cases in JSON Parsing with Swift
//
//  Created by Vandad NP on 6/28/17.
//  Copyright © 2017 Pixolity Ltd. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func example1(){
    
    let personJson = """
      {
        "first_name" : "Foo",
        "last_name" : "Bar",
        "age" : 29
      }
      """
    
    
    struct Person: Codable{
      let firstName: String
      let lastName: String
      let age: Int
      
      private enum CodingKeys: String, CodingKey{
        case firstName = "first_name"
        case lastName = "last_name"
        case age
      }
      
    }
    
    guard let data = personJson.data(using: .utf8) else {return}
    
    guard let person =
      try? JSONDecoder().decode(Person.self, from: data) else {
        return
    }
    
    print(person)
    
  }
  
  func example2(){
    
    let personJson = """
      {
        "first_name" : "Foo",
        "last_name" : "Bar",
        "age" : 29
      }
      """
    
    struct Person: Codable{
      let firstName: String
      let lastName: String
      let age: Int
      let address: String
      
      private enum CodingKeys: String, CodingKey{
        case firstName = "first_name"
        case lastName = "last_name"
        case age
        case address
      }
      
      init(from decoder: Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)
        firstName = try container.decode(String.self, forKey: .firstName)
        lastName = try container.decode(String.self, forKey: .lastName)
        age = try container.decode(Int.self, forKey: .age)
        
        address =
          (try container.decodeIfPresent(String.self, forKey: .address))
          ?? "Unknown Address"
        
      }
      
    }
    
    guard let data = personJson.data(using: .utf8) else {return}
    
    guard let person =
      try? JSONDecoder().decode(Person.self, from: data) else {
        return
    }
    
    print(person)
    
  }
  
  func example3(){
    
    struct Person: Codable{
      let firstName: String
      let lastName: String
      let age: Int
      
      func encode(to encoder: Encoder) throws{
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(firstName, forKey: .firstName)
        try container.encode(lastName, forKey: .lastName)
        try container.encode(min(age, 130), forKey: .age)
      }
      
    }
    
    let person = Person(firstName: "Foo", lastName: "Bar", age: 140)
    
    guard let personJsonData = try? JSONEncoder().encode(person) else {return}
    
    guard let samePerson = try? JSONDecoder().decode(
      Person.self, from: personJsonData) else {return}
    
    print(person)
    print(samePerson)
    
  }
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    example3()
    return true
  }
  
}

