//
//  ViewController.swift
//  Supporting Drag and Drop in Your Apps
//
//  Created by Vandad NP on 7/6/17.
//  Copyright © 2017 Pixolity Ltd. All rights reserved.
//

import UIKit

extension CGSize{
  var rounded: CGSize{
    return CGSize(width: round(width), height: round(height))
  }
}

fileprivate extension UIImage{
  var imageView: UIImageView{
    let result = UIImageView(image: self)
    result.isUserInteractionEnabled = true
    result.contentMode = .scaleAspectFit
    
    let longestSide = max(size.width, size.height)
    let maxSize = CGFloat(300)
    
    //if the image's largest size is larger than 'maxSize', then we
    //shrink it down with a transformation
    if longestSide > maxSize {
      let scale = maxSize / longestSide
      let transform = CGAffineTransform(scaleX: scale, y: scale)
      result.frame.size = size.applying(transform).rounded
    }
    
    return result
  }
}

class ViewController: UIViewController,
UIDropInteractionDelegate, UIDragInteractionDelegate{
  
  var dropPoint = CGPoint.zero
  
  var imageViews = [UIImageView]()
  
  var images: [UIImage]{
    return imageViews.flatMap{$0.image}
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.pasteConfiguration = UIPasteConfiguration(forAccepting: UIImage.self)
    view.addInteraction(UIDropInteraction(delegate: self))
    view.addInteraction(UIDragInteraction(delegate: self))
    
  }
  
  func dropInteraction(_ interaction: UIDropInteraction,
                       canHandle session: UIDropSession) -> Bool {
    return session.canLoadObjects(ofClass: UIImage.self)
  }
  
  func dropInteraction(
    _ interaction: UIDropInteraction,
    sessionDidUpdate session: UIDropSession) -> UIDropProposal {
    
    let operation: UIDropOperation
    if session.localDragSession == nil{
      operation = .copy
    } else {
      operation = .move
    }
    
    return UIDropProposal(operation: operation)
    
  }
  
  func dropInteraction(_ interaction: UIDropInteraction,
                       performDrop session: UIDropSession) {
    
    if let view = interaction.view{
      
      dropPoint = session.location(in: view)
      
      if session.localDragSession == nil{
        for item in session.items{
          extractImage(from: item.itemProvider, center: dropPoint)
        }
      }
      
    }
    
  }
  
  func dropInteraction(
    _ interaction: UIDropInteraction,
    previewForDropping item: UIDragItem,
    withDefault defaultPreview: UITargetedDragPreview)
    -> UITargetedDragPreview? {
      
      guard item.localObject != nil else {return nil}
      
      let target = UIDragPreviewTarget(container: view, center: dropPoint)
      return defaultPreview.retargetedPreview(with: target)
      
  }
  
  func dropInteraction(
    _ interaction: UIDropInteraction,
    item: UIDragItem,
    willAnimateDropWith animator: UIDragAnimating) {
    
    animator.addAnimations {
      self.fade(items: [item], alpha: 0.5)
    }
    
    let center = dropPoint
    animator.addCompletion {_ in
      guard let index = item.localObject as? Int else {return}
      self.imageViews[index].center = center
      self.imageViews[index].alpha = 1.0
    }
    
  }
  
  func extractImage(from itemProvider: NSItemProvider, center: CGPoint) {
    
    itemProvider.loadObject(ofClass: UIImage.self) {[weak self] object, _ in
      guard let `self` = self else {return}
      DispatchQueue.main.async {[weak self] in
        guard let `self` = self, let image = object as? UIImage else {return}
        let imageView = image.imageView
        imageView.center = center
        self.imageViews.append(imageView)
        self.view.addSubview(imageView)
      }
    }
    
  }
  
  func fade(items: [UIDragItem], alpha: CGFloat) {
    for item in items where item.localObject is Int {
      imageViews[item.localObject as! Int].alpha = alpha
    }
  }
  
  func dragInteraction(
    _ interaction: UIDragInteraction,
    itemsForBeginning session: UIDragSession) -> [UIDragItem] {
    
    guard let interactionView = interaction.view else {return []}
    
    let point = session.location(in: interactionView)
    
    guard let hitTestView = view?.hitTest(point, with: nil) as? UIImageView,
      let index = imageViews.index(of: hitTestView) else {
        return []
    }
    
    let image = images[index]
    let itemProvider = NSItemProvider(object: image)
    let dragItem = UIDragItem(itemProvider: itemProvider)
    dragItem.localObject = index
    
    return [dragItem]
    
  }
  
  func dragInteraction(
    _ interaction: UIDragInteraction,
    previewForLifting item: UIDragItem, session: UIDragSession)
    -> UITargetedDragPreview? {
      
      guard let index = item.localObject as? Int else {return nil}
      
      return UITargetedDragPreview(view: imageViews[index])
      
  }
  
  func dragInteraction(
    _ interaction: UIDragInteraction,
    willAnimateLiftWith animator: UIDragAnimating,
    session: UIDragSession) {
    
    animator.addCompletion { position in
      if position == .end {
        self.fade(items: session.items, alpha: 0.5)
      }
    }
    
  }
  
  func dragInteraction(
    _ interaction: UIDragInteraction,
    item: UIDragItem,
    willAnimateCancelWith animator: UIDragAnimating) {
    
    animator.addAnimations {
      self.fade(items: [item], alpha: 1)
    }
    
  }
  
  func dragInteraction(
    _ interaction: UIDragInteraction,
    session: UIDragSession,
    willEndWith operation: UIDropOperation) {
    
    if operation == .copy {
      fade(items: session.items, alpha: 1)
    }
    
  }
  
  override func paste(itemProviders: [NSItemProvider]) {
    for item in itemProviders {
      extractImage(from: item, center: dropPoint)
    }
  }
  
}

