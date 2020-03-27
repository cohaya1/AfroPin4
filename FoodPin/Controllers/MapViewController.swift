//
//  MapViewController.swift
//  FoodPin
//
//  Created by Makaveli Ohaya on 3/26/20.
//  Copyright © 2020 Makaveli Ohaya. All rights reserved.
//
import MapKit
import UIKit

class MapViewController: UIViewController,MKMapViewDelegate {

    @IBOutlet var mapView2 : MKMapView!
    var restaurant = Restaurant()
    
   override func viewDidLoad() {
            super.viewDidLoad()
    

            // Customize the map view
            mapView2.delegate = self
            mapView2.showsCompass = true
            mapView2.showsScale = true
            mapView2.showsTraffic = true
            
            // Convert address to coordinate and annotate it on map
            let geoCoder = CLGeocoder()
            geoCoder.geocodeAddressString(restaurant.location, completionHandler: { placemarks, error in
                if let error = error {
                    print(error)
                    return
                }
                
                if let placemarks = placemarks {
                    // Get the first placemark
                    let placemark = placemarks[0]
                    
                    // Add annotation
                    let annotation = MKPointAnnotation()
                    annotation.title = self.restaurant.name
                    annotation.subtitle = self.restaurant.type
                    
                    if let location = placemark.location {
                        annotation.coordinate = location.coordinate
                        
                        // Display the annotation
                        self.mapView2.showAnnotations([annotation], animated: true)
                        self.mapView2.selectAnnotation(annotation, animated: true)
                        
                    }
                }
                
            })
        }

        // MARK: - MKMapViewDelegate methods
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let identifier = "MyMarker"
            
            if annotation.isKind(of: MKUserLocation.self) {
                return nil
            }
            
            // Reuse the annotation if possible
            var annotationView: MKMarkerAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
            
            if annotationView == nil {
                annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            }
            
            annotationView?.glyphText = "😋"
            annotationView?.markerTintColor = UIColor.orange
            
            return annotationView
        }
    }
