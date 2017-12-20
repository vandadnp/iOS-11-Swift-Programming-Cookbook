//: Playground - noun: a place where people can play

import UIKit

let cakeTemperature = Measurement(value: 180, unit: UnitTemperature.celsius)
let potatoesTemperature = Measurement(value: 200, unit: UnitTemperature.fahrenheit)
let beefTemperature = Measurement(value: 459, unit: UnitTemperature.kelvin)

let sorted = [cakeTemperature, potatoesTemperature, beefTemperature]
  .sorted { (first, second) -> Bool in
    return first.converted(to: .celsius) < second.converted(to: .celsius)
}

let allCelciusTemperatures = sorted.map{
  $0.converted(to: .celsius)
}

allCelciusTemperatures //93.33, 180, 185.8
