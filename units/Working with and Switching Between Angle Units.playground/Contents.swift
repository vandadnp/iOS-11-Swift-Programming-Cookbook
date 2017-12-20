//: Playground - noun: a place where people can play

import UIKit

let gradiens = Measurement(value: 100, unit: UnitAngle.gradians) //100.0 grad
gradiens.converted(to: UnitAngle.degrees) //90°
type(of: gradiens) //Measurement<UnitAngle>

let degrees = Measurement(value: 180, unit: UnitAngle.degrees) //180.0

let total = gradiens - degrees //-90 °

let finalGradiens = total.converted(to: .gradians) //-100 grad
let finalDegrees = total.converted(to: UnitAngle.degrees) //-90 °

let string = "\(finalDegrees.value) \(finalDegrees.unit.symbol)" //"-90 °"
