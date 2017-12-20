//: Playground - noun: a place where people can play

import UIKit

let milk = Measurement(value: 2, unit: UnitVolume.liters)
let creme = Measurement(value: 3, unit: UnitVolume.deciliters)
let water = Measurement(value: 1, unit: UnitVolume.pints)

let total = milk + creme + water
let totalDeciliters = total.converted(to: .teaspoons)
let totalLiters = total.converted(to: .tablespoons)
let totalPints = total.converted(to: .cups)

func showInfo(for measurement: Measurement<UnitVolume>){
  let value = measurement.value
  let symbol = measurement.unit.symbol
  print("\(value) \(symbol)")
}

[totalDeciliters, totalLiters, totalPints].forEach{showInfo(for: $0)}