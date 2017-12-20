//: Playground - noun: a place where people can play

import UIKit

let names = [
  "Joey",
  "Andrew",
  "Suzanne",
  "Jonathan",
  "Sara",
  "Adriana",
]

let dict = Dictionary(grouping: names) {(items: String) -> Character in
  return items.first ?? "?"
}

//let dict = Dictionary(grouping: names) {(items: String) -> Int in
//  return items.characters.count
//}

dict


/*dict is now equal to
 
["J": ["Joey", "Jonathan"],
 "A": ["Andrew", "Adriana"],
 "S": ["Suzanne", "Sara"]]
 
 */
