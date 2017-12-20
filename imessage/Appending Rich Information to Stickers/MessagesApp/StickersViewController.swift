//
//  StickersViewController.swift
//  Utilizing an Extended View in a Sticker Pack App
//
//  Created by Vandad on 7/25/16.
//  Copyright © 2016 Pixolity. All rights reserved.
//

import UIKit

protocol StickersViewControllerDelegate : class{
  func plusButtonTappedOn(controller: UIViewController)
}

protocol HasStickersDelegate : class{
  weak var delegate: StickersViewControllerDelegate? {get set}
}

class StickersViewController: UICollectionViewController, HasStickersDelegate {
  
  weak var delegate: StickersViewControllerDelegate?

  //we set this to Cell in IB as well, remember?
  private let reuseIdentifier = "Cell"
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  override func collectionView(_ collectionView: UICollectionView,
                               numberOfItemsInSection section: Int) -> Int {
    return 1
  }
  
  override func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: reuseIdentifier, for: indexPath)
    
    return cell
  }
  
  override func collectionView(_ collectionView: UICollectionView,
                               didSelectItemAt indexPath: IndexPath) {
    guard indexPath.row == 0 && indexPath.section == 0 else {return}
    delegate?.plusButtonTappedOn(controller: self)
  }
  
}
