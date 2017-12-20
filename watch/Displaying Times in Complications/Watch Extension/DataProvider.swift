//
//  DataProvider.swift
//  Constructing Small Complications with Text and Images
//
//  Created by Vandad on 8/7/15.
//  Copyright © 2015 Pixolity. All rights reserved.
//

import Foundation

protocol Pausable{
  var name: String {get}
  var date: Date {get}
}

struct PauseAtWork : Pausable{
  let name: String
  let date: Date
}

struct DataProvider{
  
  func allPausesToday() -> [PauseAtWork]{
    
    var all = [PauseAtWork]()
    
    let now = Date()
    let cal = Calendar.current
    
    let unitsArray: [Calendar.Component] = [.year, .month, .day]
    let units = Set(unitsArray)
    
    var comps = cal.dateComponents(units, from: now)
    comps.calendar = cal
    comps.minute = 30
    
    comps.hour = 11
    all.append(
      PauseAtWork(name: "Coffee", date: comps.date!))
    
    comps.minute = 30
    comps.hour = 14
    all.append(
      PauseAtWork(name: "Lunch", date: comps.date!))
    
    comps.minute = 0
    comps.hour = 16
    all.append(
      PauseAtWork(name: "Tea", date: comps.date!))
    
    comps.hour = 17
    all.append(
      PauseAtWork(name: "Dinner", date: comps.date!))
    
    return all
    
  }
  
}
