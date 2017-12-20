import Foundation

struct Car: Codable{
  let name: String
}

struct Person: Codable{
  
  let name: String
  let age: Int
  let car: Car
  
}

let foo = Person(name: "Foo", age: 22, car: Car(name: "VW up!"))

func == (lhs: Car, rhs: Car) -> Bool{
  return lhs.name == rhs.name
}

func == (lhs: Person, rhs: Person) -> Bool{
  return
    lhs.name == rhs.name &&
      lhs.age == rhs.age &&
      lhs.car == rhs.car
}

if let data = try? JSONEncoder().encode(foo){
  if let newFoo = try? JSONDecoder().decode(Person.self, from: data){
    if newFoo == foo{
      print("They are the same")
    } else {
      print("They are not the same")
    }
  }
}