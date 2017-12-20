import Foundation

struct Car{
  let name: String
}

struct Person{
  
  let name: String
  let age: Int
  let car: Car
  
}

let foo = Person(name: "Foo", age: 22, car: Car(name: "VW up!"))
let bar = Person(name: "Bar", age: 25, car: Car(name: "VW Tiguan"))
let baz = Person(name: "Baz", age: 30, car: Car(name: "VW Sharan"))

//let carNameKeyPath = \Person.car.name
//
//let carNames = [foo, bar, baz].map{$0[keyPath: carNameKeyPath]}
//carNames // ["VW up!", "VW Tiguan", "VW Sharan"]


let personCarKeyPath = \Person.car
let nameOfCarKeyPath = \Car.name

let fullKeyPath = personCarKeyPath.appending(path: nameOfCarKeyPath)
let carNames = [foo, bar, baz].map{$0[keyPath: fullKeyPath]}
carNames // ["VW up!", "VW Tiguan", "VW Sharan"]
