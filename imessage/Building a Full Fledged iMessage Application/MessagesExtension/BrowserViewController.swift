//
//  BrowserViewController.swift
//  Building a Custom Sticker Pack Application
//
//  Created by Vandad on 7/25/16.
//  Copyright © 2016 Pixolity. All rights reserved.
//

import UIKit
import Messages
import Foundation

extension MSSticker{
  
  enum MSStickerItem : String{
    case Burning, Alert, Accounts
  }
  
  convenience init(item: MSStickerItem) throws{
    try self.init(contentsOfFileURL:
      Bundle.main.url(forResource: item.rawValue, withExtension: "png")!,
                  localizedDescription: "")
  }
}

class BrowserViewController: MSStickerBrowserViewController {
  
  let stickers = [
    try! MSSticker(item: .Burning),
    try! MSSticker(item: .Alert),
    try! MSSticker(item: .Accounts),
  ]
  
  override func numberOfStickers(in
    stickerBrowserView: MSStickerBrowserView) -> Int {
    return stickers.count
  }
  
  override func stickerBrowserView(_ stickerBrowserView: MSStickerBrowserView,
                                   stickerAt index: Int) -> MSSticker {
    return stickers[index]
  }
  
}
