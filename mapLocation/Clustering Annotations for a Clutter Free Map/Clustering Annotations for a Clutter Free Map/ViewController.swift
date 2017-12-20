//
//  ViewController.swift
//  Clustering Annotations for a Clutter Free Map
//
//  Created by Vandad NP on 7/27/17.
//  Copyright © 2017 Pixolity Ltd. All rights reserved.
//

import UIKit
import MapKit

class Annotation: NSObject, MKAnnotation{
  
  var coordinate: CLLocationCoordinate2D
  var title: String?
  var subtitle: String?
  let clusteringIdentifier: String?
  
  init (coordinate: CLLocationCoordinate2D,
        title: String? = nil,
        subtitle: String? = nil,
        clusteringIdentifier: String? = nil){
    
    self.coordinate = coordinate
    self.title = title
    self.subtitle = subtitle
    self.clusteringIdentifier = clusteringIdentifier
    
    super.init()
    
  }
  
  convenience init (lat: CLLocationDegrees,
                    long: CLLocationDegrees,
                    clusteringIdentifier: String){
    self.init(
      coordinate:CLLocationCoordinate2D(latitude: lat, longitude: long),
      title: nil,
      subtitle: nil,
      clusteringIdentifier: clusteringIdentifier
    )
    
  }
  
}

class ViewController: UIViewController, MKMapViewDelegate {
  
  @IBOutlet weak var mapView: MKMapView!
  
  private var firstGroupOfAnnotations: [Annotation]{
    let id = "Borgholm Center"
    return [
      Annotation(lat: 56.878785, long: 16.648149, clusteringIdentifier: id),
      Annotation(lat: 56.882349, long: 16.651926, clusteringIdentifier: id),
      Annotation(lat: 56.883193, long: 16.654673, clusteringIdentifier: id),
      Annotation(lat: 56.879536, long: 16.653299, clusteringIdentifier: id),
      Annotation(lat: 56.879254, long: 16.657419, clusteringIdentifier: id),
      Annotation(lat: 56.877472, long: 16.655359, clusteringIdentifier: id),
      Annotation(lat: 56.879348, long: 16.660852, clusteringIdentifier: id),
      Annotation(lat: 56.878316, long: 16.653643, clusteringIdentifier: id)
    ]
  }
  
  private var secondGroupOfAnnotations: [Annotation]{
    let id = "Borgholm"
    return [
      Annotation(lat: 56.879629, long: 16.662569, clusteringIdentifier: id),
      Annotation(lat: 56.880286, long: 16.664629, clusteringIdentifier: id),
      Annotation(lat: 56.879348, long: 16.662569, clusteringIdentifier: id),
      Annotation(lat: 16.662569, long: 16.661024, clusteringIdentifier: id),
      Annotation(lat: 56.883100, long: 16.669950, clusteringIdentifier: id),
      Annotation(lat: 56.879067, long: 16.666002, clusteringIdentifier: id),
      Annotation(lat: 56.878222, long: 16.664114, clusteringIdentifier: id),
      Annotation(lat: 56.877847, long: 16.663599, clusteringIdentifier: id),
    ]
  }
  
  private var thirdGroupOfAnnotations: [Annotation]{
    let id = "Borgholm Suburbs"
    return [
      Annotation(lat: 56.874564, long: 16.661196, clusteringIdentifier: id),
      Annotation(lat: 56.875408, long: 16.662741, clusteringIdentifier: id),
      Annotation(lat: 56.878504, long: 16.667204, clusteringIdentifier: id),
      Annotation(lat: 56.877191, long: 16.666346, clusteringIdentifier: id),
      Annotation(lat: 56.876534, long: 16.667547, clusteringIdentifier: id),
      Annotation(lat: 56.876253, long: 16.666002, clusteringIdentifier: id),
      Annotation(lat: 56.878129, long: 16.671152, clusteringIdentifier: id),
      Annotation(lat: 56.877284, long: 16.667376, clusteringIdentifier: id),
    ]
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    mapView.register(
      MKMarkerAnnotationView.self,
      forAnnotationViewWithReuseIdentifier:
      MKMapViewDefaultAnnotationViewReuseIdentifier)
    
    mapView.addAnnotations(firstGroupOfAnnotations)
    mapView.addAnnotations(secondGroupOfAnnotations)
    mapView.addAnnotations(thirdGroupOfAnnotations)
    
  }
  
  func mapView(_ mapView: MKMapView,
               viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    
    guard let annotation = annotation as? Annotation else {return nil}
    
    guard let view = mapView.dequeueReusableAnnotationView(
      withIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier) as?
      MKMarkerAnnotationView else {return nil}
    
    view.animatesWhenAdded = true
    view.titleVisibility = .adaptive
    view.subtitleVisibility = .adaptive
    view.clusteringIdentifier = annotation.clusteringIdentifier
    
    return nil
  }
  
  
}


