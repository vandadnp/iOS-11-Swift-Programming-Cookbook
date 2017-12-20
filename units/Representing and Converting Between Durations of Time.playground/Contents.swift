//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

extension Double{
  var seconds: Measurement<UnitDuration>{
    return Measurement(value: self, unit: UnitDuration.seconds)
  }
}

var remainingTime = Measurement(value: 10, unit: UnitDuration.seconds)
Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {timer in
  let minutesRemaining = remainingTime.converted(to: UnitDuration.minutes)
  print("\(minutesRemaining.value) minutes remaining before the timer stops")
  remainingTime = remainingTime - (1.0).seconds
  if remainingTime.value <= 0.0{
    timer.invalidate()
  }
}

extension Double{
  var hours: Measurement<UnitDuration>{
    return Measurement(value: self, unit: UnitDuration.hours)
  }
  var minutes: Measurement<UnitDuration>{
    return Measurement(value: self, unit: UnitDuration.minutes)
  }
}

let trainJourneyDuration = (1.25).hours
trainJourneyDuration.converted(to: .minutes) //75.0 min

let planeJourneyDuration = (320.0).minutes
planeJourneyDuration.converted(to: .hours) //5.333 hr

let boatJourneyDuration = (1500.0).seconds
boatJourneyDuration.converted(to: .minutes) //25.0 min

let journeys = [
  trainJourneyDuration,
  planeJourneyDuration,
]

let finalJourneyDurationInMinutes = journeys.reduce(0.0){
  return $0 + $1.converted(to: UnitDuration.minutes).value
}

finalJourneyDurationInMinutes //395

