import Foundation

let name = "Outside name"

func example1(){
  if name.characters.count == 0{
    print("The string \(name) is empty")
  } else {
    print("Non-empty string = \(name)")
  }
}

func example2(){
  print(name)
}
