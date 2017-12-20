//
//  TableViewController.swift
//  SnapshotTesting
//
//  Created by Vandad NP on 5/14/17.
//  Copyright © 2017 Pixolity Ltd. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController{
  
  override func tableView(_ tableView: UITableView,
                          numberOfRowsInSection section: Int) -> Int {
    return 2
  }
  
  override func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell: UITableViewCell
    
    if indexPath.row == 0 {
      cell = tableView
        .dequeueReusableCell(withIdentifier: "pinkFloyd", for: indexPath)
    } else {
      cell = tableView
        .dequeueReusableCell(withIdentifier: "symphonyX", for: indexPath)
    }
    
    return cell
    
  }
  
}
