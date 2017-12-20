//: Playground - noun: a place where people can play

import UIKit

var myCpuClock = Measurement(value: 3.5, unit: UnitFrequency.gigahertz)
var yourCpuClock = Measurement(value: 3400, unit: UnitFrequency.megahertz)

if myCpuClock > yourCpuClock{
  "My cpu is faster than yours"
} else if yourCpuClock > myCpuClock{
  "Your cpu is faster than mine. Good for you!"
} else {
  "It seems our cpu clocks are the same!"
}

let baseUnit = UnitFrequency.gigahertz
[myCpuClock, yourCpuClock].enumerated().forEach{offset, cpuClock in
  let converted = cpuClock.converted(to: baseUnit)
  print("cpu #\(offset + 1) is \(converted.value) \(converted.unit.symbol)")
}
