//
//  ViewController.swift
//  Displaying System Annotations on the Map
//
//  Created by Vandad NP on 7/12/17.
//  Copyright © 2017 Pixolity Ltd. All rights reserved.
//

import UIKit
import MapKit

class Annotation: NSObject, MKAnnotation{
  
  var coordinate: CLLocationCoordinate2D
  var title: String?
  var subtitle: String?
  
  init (coordinate: CLLocationCoordinate2D,
        title: String?,
        subtitle: String?){
    
    self.coordinate = coordinate
    self.title = title
    self.subtitle = subtitle
    
    super.init()
    
  }
  
}

extension CLLocationCoordinate2D{
  
  static var southOfSweden: CLLocationCoordinate2D{
    return CLLocationCoordinate2D(latitude: 57.166096, longitude: 16.993009)
  }
  
}

extension CLLocationCoordinate2D{
  
  func annotation(withTitle title: String?, subTitle: String?) -> Annotation{
    return Annotation(coordinate: self, title: title, subtitle: subTitle)
  }
  
}

class ViewController: UIViewController, MKMapViewDelegate {
  
  @IBOutlet weak var mapView: MKMapView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    mapView.register(
      MKMarkerAnnotationView.self,
      forAnnotationViewWithReuseIdentifier:
      MKMapViewDefaultAnnotationViewReuseIdentifier)
    
    let southOfSweden =
      CLLocationCoordinate2D.southOfSweden.annotation(
        withTitle: "Lottorp", subTitle: "Centrum")
    
    mapView.addAnnotation(southOfSweden)
    
  }
  
  func mapView(_ mapView: MKMapView,
               viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    
    guard let view = mapView.dequeueReusableAnnotationView(
      withIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier) as?
      MKMarkerAnnotationView else {return nil}
    
    view.animatesWhenAdded = true
    view.titleVisibility = .adaptive
    view.subtitleVisibility = .adaptive
    
    return nil
  }
  
  
}

