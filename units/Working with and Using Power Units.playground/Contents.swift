//: Playground - noun: a place where people can play

import UIKit

let myCyclingPower = Measurement(value: 160, unit: UnitPower.watts)
let superCyclistPower = Measurement(value: 0.40, unit: UnitPower.horsepower)

if myCyclingPower > superCyclistPower{
  "Wow I am really strong"
} else if myCyclingPower < superCyclistPower{
  "The super cyclist is of course stronger than I am"
} else {
  "It seems I am as strong as the super cyclist!"
}

