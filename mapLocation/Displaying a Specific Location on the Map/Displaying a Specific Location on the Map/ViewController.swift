//
//  ViewController.swift
//  Displaying a Specific Location on the Map
//
//  Created by Vandad on 8/30/16.
//  Copyright © 2016 Pixolity. All rights reserved.
//

import UIKit
import MapKit

class Annotation : NSObject, MKAnnotation{
  let coordinate: CLLocationCoordinate2D
  let title: String?
  let subtitle: String?
  
  init(latitude: CLLocationDegrees, longitude: CLLocationDegrees,
       title: String?, subtitle: String?){
    self.coordinate = CLLocationCoordinate2D(latitude: latitude,
                                             longitude: longitude)
    self.title = title
    self.subtitle = subtitle
  }
  
}

extension Annotation{
  var region: MKCoordinateRegion{
    let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    return MKCoordinateRegion(center: coordinate, span: span)
  }
}

class ViewController: UIViewController {
  
  @IBOutlet var mapView: MKMapView!
  
  func display(latitude: CLLocationDegrees,
               longitude: CLLocationDegrees,
               title: String? = nil,
               subtitle: String? = nil){
    
    let annotation = Annotation(latitude: latitude,
                                longitude: longitude,
                                title: title,
                                subtitle: subtitle)
    
    mapView.addAnnotation(annotation)
    
    mapView.setRegion(annotation.region, animated: false)
    
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let stockholmCentralStation = (lat: 59.330139, long: 18.058155)
    
    display(latitude: stockholmCentralStation.lat,
            longitude: stockholmCentralStation.long,
            title: "Central Station",
            subtitle: "Stockholm")
    
  }
  
  
}

