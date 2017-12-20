//
//  MyViewSnapshotTest.swift
//  SnapshotTesting
//
//  Created by Vandad NP on 5/10/17.
//  Copyright © 2017 Pixolity Ltd. All rights reserved.
//

import XCTest
import FBSnapshotTestCase
@testable import SnapshotTesting

class MyViewSnapshotTest: FBSnapshotTestCase {
  
  override func setUp() {
    super.setUp()
    
    recordMode = false
    
  }
  
  func testMyView(){
    
    let rect = CGRect(x: 0, y: 0, width: 200, height: 200)
    let view = MyView(frame: rect)
    
    FBSnapshotVerifyView(view, tolerance: 0.2)
    
  }
  
}
