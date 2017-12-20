//
//  DocumentFinder.swift
//  DocumentApp
//
//  Created by Vandad NP on 7/25/17.
//  Copyright © 2017 Pixolity Ltd. All rights reserved.
//

import Foundation

class DocumentFinder{
  
  //Bool = isFound
  typealias Completion = (Bool) -> Void
  
  private let documentName: String
  private let completion: Completion
  
  init(documentName name: String, completion handler: @escaping Completion){
    documentName = name
    completion = handler
  }
  
  //the rest of our code will be placed here shortly ...
  
  private lazy var query: NSMetadataQuery = {
    let query = NSMetadataQuery()
    query.searchScopes = [NSMetadataQueryUbiquitousDocumentsScope]
    
    query.predicate = NSPredicate(
      format: "%K ==[cd] '\(documentName)'",
      NSMetadataItemFSNameKey)
    
    return query
  }()
  
  @discardableResult func start() -> Bool{
    guard !query.isStarted else {return false}
    
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(didFinishGathering(notification:)),
      name: .NSMetadataQueryDidFinishGathering,
      object: nil)
    
    return query.start()
  }
  
  @objc func didFinishGathering(notification: Notification){
    NotificationCenter.default.removeObserver(self)
    query.stop()
    completion(query.resultCount > 0)
  }
  
}
