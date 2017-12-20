//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

class TappableView : UIView{
  
  @objc func handleTaps(_ sender: UITapGestureRecognizer){
    PlaygroundPage.current.finishExecution()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    let recognizer = UITapGestureRecognizer(
      target: self, action: #selector(TappableView.handleTaps(_:)))
    addGestureRecognizer(recognizer)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

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

let view = TappableView(frame: 300.toSize.toRectWithZeroOrigin)
view.backgroundColor = .blue
PlaygroundPage.current.liveView = view
