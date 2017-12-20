//
//  ImageEditorViewController.swift
//  DocumentApp
//
//  Created by Vandad NP on 7/20/17.
//  Copyright © 2017 Pixolity Ltd. All rights reserved.
//

import UIKit

class ImageEditorViewController: UIViewController, ImageEditorViewDelegate {
  
  private class var newFileUrl: URL?{
    
    let fileManager = FileManager()
    
    guard let documentsFolder = try? fileManager.url(
      for: .documentDirectory,
      in: .userDomainMask,
      appropriateFor: nil,
      create: true) else {
        return nil
    }
    
    let randomNumber = arc4random_uniform(10)
    let fileName = "Untitled \(randomNumber)"
    let fileUrl = documentsFolder.appendingPathComponent(fileName)
    
    guard !fileManager.fileExists(atPath: fileUrl.path) else{
      //the file exists already, we won't override it
      return nil
    }
    
    return fileUrl
    
  }
  
  private var fileUrl: URL!
  
  typealias NewDocumentHandler = (URL?, UIViewController?) -> Void
  class func createNewDocumentViewController(
    withHandler handler: @escaping NewDocumentHandler){
    
    //get a file URL
    guard let fileUrl = newFileUrl else {
      handler(nil, nil)
      return
    }
    
    //we will create an empty file at the given path now
    do{
      try Data().write(to: fileUrl, options: .atomicWrite)
    } catch {
      handler(nil, nil)
      return
    }
    
    //load our view controller from the storyboard file
    guard let navController =
      UIStoryboard(
        name: "ImageEditorViewController",
        bundle: nil).instantiateInitialViewController()
        as? UINavigationController,
      let viewController = navController.viewControllers.first
        as? ImageEditorViewController else {
          handler(nil, nil)
          return
    }
    
    //set the file URL and then call the handler
    viewController.fileUrl = fileUrl
    
    handler(fileUrl, navController)
    
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
    dismiss(animated: true, completion: nil)
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
