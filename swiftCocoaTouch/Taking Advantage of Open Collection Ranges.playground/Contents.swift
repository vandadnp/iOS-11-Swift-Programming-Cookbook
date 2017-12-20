//: Playground - noun: a place where people can play

import UIKit

let names = ["foo", "bar", "baz"]
let allNamesExceptForFirstName = names.dropFirst()
//allNamesExceptForFirstName = ["bar", "baz"]

let exceptForFirstName = names[1...]
//exceptForFirstName = ["bar", "baz"]

func decideIfAppropriateAgeForDriving(_ age: Int){
  
  switch age{
  case ..<0:
    print("Unborn child?!")
  case 16...:
    print("Allowed to drive")
  default:
    print("Not allowed to drive")
  }
  
}

//open starting range
decideIfAppropriateAgeForDriving(-10) //prints "Unborn child?!"

//default case
decideIfAppropriateAgeForDriving(14) //prints "Not allowed to drive"
decideIfAppropriateAgeForDriving(10) //prints "Not allowed to drive"

//open ended range
decideIfAppropriateAgeForDriving(16) //prints "Allowed to drive"
decideIfAppropriateAgeForDriving(52) //prints "Allowed to drive"
