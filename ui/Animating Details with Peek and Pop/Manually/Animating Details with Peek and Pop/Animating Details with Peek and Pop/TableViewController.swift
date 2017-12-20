//
//  TableViewController.swift
//  Animating Details with Peek and Pop
//
//  Created by Vandad NP on 2/28/17.
//  Copyright © 2017 Pixolity Ltd. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController,
UIViewControllerPreviewingDelegate {
  
  func previewingContext(_ previewingContext: UIViewControllerPreviewing,
                         commit viewControllerToCommit: UIViewController) {
    navigationController?.pushViewController(viewControllerToCommit,
                                             animated: false)
  }
  
  func previewingContext(
    _ previewingContext: UIViewControllerPreviewing,
    viewControllerForLocation location: CGPoint) -> UIViewController? {
    
    //construct a new image view controller
    guard let imageVc = UIStoryboard(name: "Main", bundle: nil)
      .instantiateViewController(withIdentifier: "ImageViewController")
      as? ImageViewController else {return nil}
    
    //get the image for the cell the user is 3D Touching
    guard let indexPath = tableView.indexPathForRow(at: location),
      let cell = tableView.cellForRow(at: indexPath),
      let image = cell.imageView?.image else {return nil}
    
    //tell iOS where to show the animation from
    previewingContext.sourceRect = tableView.rectForRow(at: indexPath)
    
    //set the image and return the vc
    imageVc.image = image
    imageVc.preferredContentSize = CGSize(width: 200.0, height: 200.0)
    
    return imageVc
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if traitCollection.forceTouchCapability == .available{
      registerForPreviewing(with: self, sourceView: tableView)
    }
    
  }
  
}
