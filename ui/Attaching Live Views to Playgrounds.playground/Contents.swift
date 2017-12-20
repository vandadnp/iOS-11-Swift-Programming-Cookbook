//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

extension Double{
  var toSize: CGSize{
    return .init(width: self, height: self)
  }
}

extension CGSize{
  var toRectWithZeroOrigin: CGRect{
    return CGRect(origin: .zero, size: self)
  }
}

let view = UIView(frame: 300.toSize.toRectWithZeroOrigin)
view.backgroundColor = .blue
PlaygroundPage.current.liveView = view
