//
//  TableViewCellSnapshotTests.swift
//  SnapshotTesting
//
//  Created by Vandad NP on 5/14/17.
//  Copyright © 2017 Pixolity Ltd. All rights reserved.
//

import XCTest
import FBSnapshotTestCase
@testable import SnapshotTesting

class TableViewCellSnapshotTests: FBSnapshotTestCase {
  
  var tableViewController: TableViewController!
  
  override func setUp() {
    super.setUp()
    
    let appBundle = Bundle(for: TableViewController.self)
    
    guard let tableViewController =
      UIStoryboard(name: "Main", bundle: appBundle)
        .instantiateViewController(withIdentifier: "TableViewController")
        as? TableViewController else{
          
          XCTFail()
          return
          
    }
    
    self.tableViewController = tableViewController
    
    recordMode = false
  }
  
  
  func testCell(withIdentifier identifier: String){
    
    
    
    guard let cell = tableViewController
      .tableView.dequeueReusableCell(withIdentifier: identifier) else {
        
        XCTFail()
        return
        
    }
    
    let view = cell.contentView
    
    FBSnapshotVerifyView(view)
    
  }
  
  func testPinkFloydCell() {
    
    testCell(withIdentifier: "pinkFloyd")
    
  }
  
  func testSymphonyXCell(){
    
    testCell(withIdentifier: "symphonyX")
    
  }
  
}
