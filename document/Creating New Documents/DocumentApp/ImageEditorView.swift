//
//  ImageEditorView.swift
//  DocumentApp
//
//  Created by Vandad NP on 7/20/17.
//  Copyright © 2017 Pixolity Ltd. All rights reserved.
//

import UIKit

protocol ImageEditorViewDelegate: class{
  //empty for now
}

class ImageEditorView: UIView {
  
  private var delegate: ImageEditorViewDelegate?
  
  init(delegate: ImageEditorViewDelegate) {
    super.init(frame: .zero)
    self.delegate = delegate
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

}
