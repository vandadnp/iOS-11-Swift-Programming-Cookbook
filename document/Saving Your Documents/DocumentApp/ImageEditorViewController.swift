//
//  ImageEditorViewController.swift
//  DocumentApp
//
//  Created by Vandad NP on 7/20/17.
//  Copyright © 2017 Pixolity Ltd. All rights reserved.
//

import UIKit

class ImageEditorViewController: UIViewController, ImageEditorViewDelegate {
  
  //will get set in our custom initializer
  private var fileUrl: URL!
  
  private var imageDocument: ImageDocument!
  
  func imageEditorView(view: ImageEditorView, hasDataForImage data: Data) {
    imageDocument.imageData = data
    
    imageDocument.save(
      to: imageDocument.fileURL,
      for: .forOverwriting) {succeeded in
        
        if succeeded{
          print("Successfully saved the data")
        } else {
          print("Failed to save the document")
        }
        
    }
  }
  
  class func newInstance(withFileUrl fileUrl: URL) -> UIViewController{
    
    //load our view controller from the storyboard file
    guard let navController =
      UIStoryboard(
        name: "ImageEditorViewController",
        bundle: nil).instantiateInitialViewController()
        as? UINavigationController,
      let viewController = navController.viewControllers.first
        as? ImageEditorViewController else {
          return UIViewController()
    }
    
    //set the file URL and then call the handler
    viewController.fileUrl = fileUrl
    
    return navController
    
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = fileUrl.lastPathComponent
    
    let close = UIBarButtonItem(
      title: "Done", style: .done, target: self,
      action: #selector(ImageEditorViewController.done))
    navigationItem.setLeftBarButton(close, animated: false)
    
  }
  
  @objc func done(){
    imageDocument.close {[weak self] succeeded in
      guard let `self` = self else {return}
      
      if succeeded{
        print("Successfully closed the document")
      } else {
        print("Failed to close the document")
      }
      
      self.dismiss(animated: true, completion: nil)
    }
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    imageDocument = ImageDocument(fileURL: fileUrl)
    
    imageDocument.open {[weak self] succeeded in
      guard let `self` = self else {return}
      guard succeeded else {
        self.displayFailedToOpenDocumentAlert()
        return
      }
    }
    
  }
  
  private func displayFailedToOpenDocumentAlert(){
    
    let alert = UIAlertController(
      title: nil,
      message: "Failed to open the document!",
      preferredStyle: .alert)
    
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    present(alert, animated: true, completion: nil)
    
  }
  
  private func displayIntroMessage(){
    
    let alert = UIAlertController(
      title: nil,
      message: "Drag your finger across the screen to start drawing!",
      preferredStyle: .alert)
    
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    present(alert, animated: true, completion: nil)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    displayIntroMessage()
  }
  
  override func loadView() {
    view = ImageEditorView(delegate: self)
    view.backgroundColor = .white
  }
  
}
