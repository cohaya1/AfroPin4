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
    @IBOutlet var ExitMapButton : UIButton!
    @IBOutlet var segmentedcontrol : UISegmentedControl!
    @IBOutlet weak var NearbyButton : UIButton!
   
    
    var currentPlacemark: CLPlacemark?
    var currentTransportType = MKDirectionsTransportType.automobile
    var currentRoute: MKRoute?
    var restaurant: RestaurantMO!
    var detailinfo: RestaurantDetailIconTextCellTableView!
    let locationmanager = CLLocationManager()
    
   override func viewDidLoad() {
            super.viewDidLoad()
    navigationController?.navigationBar.tintColor = .red
   segmentedcontrol.isHidden = true
   segmentedcontrol.addTarget(self, action: #selector(showDirection), for: .valueChanged)
    // Request User Auth for location services
    locationmanager.requestWhenInUseAuthorization()
    let status = CLLocationManager.authorizationStatus()
    
    if status == CLAuthorizationStatus.authorizedWhenInUse {
        mapView2.showsUserLocation = true
    }
            // Show User Location
    mapView2.showsUserLocation = true
    
    
            // Customize the map view
            mapView2.delegate = self
            mapView2.showsCompass = true
            mapView2.showsScale = true
            mapView2.showsTraffic = true
            
            // Convert address to coordinate and annotate it on map
            let geoCoder = CLGeocoder()
            geoCoder.geocodeAddressString(restaurant.location ?? "", completionHandler: { placemarks, error in
                if let error = error {
                    print(error)
                    return
                }
                
                if let placemarks = placemarks {
                    // Get the first placemark
                    let placemark = placemarks[0]
                     self.currentPlacemark = placemark
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
    override func didReceiveMemoryWarning() {
             super.didReceiveMemoryWarning()
             // Dispose of any resources that can be recreated.
         }
       
         // MARK: - MKMapViewDelegate methods
         
         func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
             let identifier = "MyMarker"
             
             if annotation.isKind(of: MKUserLocation.self) {
                 return nil
             }
             
             // Reuse the annotation if possible
             var annotationView: MKAnnotationView?
             
             if #available(iOS 11.0, *) {
                 var markerAnnotationView: MKMarkerAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
                 
                 if markerAnnotationView == nil {
                     markerAnnotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                     markerAnnotationView?.canShowCallout = true
                 }
                 
                 markerAnnotationView?.glyphText = "😋"
                 markerAnnotationView?.markerTintColor = UIColor.orange
             
                 annotationView = markerAnnotationView
                 
             } else {
                 
                 var pinAnnotationView: MKPinAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
                 
                 if pinAnnotationView == nil {
                     pinAnnotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                     pinAnnotationView?.canShowCallout = true
                     pinAnnotationView?.pinTintColor = UIColor.orange
                 }

                 annotationView = pinAnnotationView
             }
             
             let leftIconView = UIImageView(frame: CGRect.init(x: 0, y: 0, width: 53, height: 53))
            if let restaurantImage = restaurant.image{
            leftIconView.image = UIImage(data: restaurantImage as Data)
            }
             annotationView?.leftCalloutAccessoryView = leftIconView
             annotationView?.rightCalloutAccessoryView = UIButton(type: UIButton.ButtonType.detailDisclosure)
         
             return annotationView
         }
         
         func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
             let renderer = MKPolylineRenderer(overlay: overlay)
             renderer.strokeColor = (currentTransportType == .automobile) ? UIColor.blue : UIColor.orange
             renderer.lineWidth = 3.0
             
             return renderer
         }
         
         func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
             
             performSegue(withIdentifier: "showSteps", sender: view)
         }
         
         
         // MARK: - Action methods
         
         @IBAction func showDirection(sender: UIButton) {
             guard let currentPlacemark = currentPlacemark else {
                 return
             }
             
             switch segmentedcontrol.selectedSegmentIndex {
             case 0: currentTransportType = .automobile
             case 1: currentTransportType = .walking
             default: break
             }
             
             segmentedcontrol.isHidden = false
             
             let directionRequest = MKDirections.Request()
             
             // Set the source and destination of the route
             directionRequest.source = MKMapItem.forCurrentLocation()
             let destinationPlacemark = MKPlacemark(placemark: currentPlacemark)
             directionRequest.destination = MKMapItem(placemark: destinationPlacemark)
             directionRequest.transportType = currentTransportType
             
             // Calculate the direction
             let directions = MKDirections(request: directionRequest)
             
             directions.calculate { (routeResponse, routeError) -> Void in
                 
                 guard let routeResponse = routeResponse else {
                     if let routeError = routeError {
                         print("Error: \(routeError)")
                     }
                     
                     return
                 }
                 
                 let route = routeResponse.routes[0]
                 self.currentRoute = route
                 self.mapView2.removeOverlays(self.mapView2.overlays)
                 self.mapView2.addOverlay(route.polyline, level: MKOverlayLevel.aboveRoads)
                 
                 let rect = route.polyline.boundingMapRect
                 self.mapView2.setRegion(MKCoordinateRegion.init(rect), animated: true)
                
             }
             
             
         }
   
         @IBAction func showNearby(sender: UIButton) {
            
             let searchRequest = MKLocalSearch.Request()
             searchRequest.naturalLanguageQuery = restaurant.type
            searchRequest.region = mapView2.region
             
             let localSearch = MKLocalSearch(request: searchRequest)
             localSearch.start { (response, error) -> Void in
                 guard let response = response else {
                     if let error = error {
                         print(error)
                     }
                     
                     return
                 }
                 
                 let mapItems = response.mapItems
                 var nearbyAnnotations: [MKAnnotation] = []
                 if mapItems.count > 0 {
                     for item in mapItems {
                         // Add annotation
                         let annotation = MKPointAnnotation()
                         annotation.title = item.name
                         annotation.subtitle = item.phoneNumber
                         if let location = item.placemark.location {
                             annotation.coordinate = location.coordinate
                         }
                         nearbyAnnotations.append(annotation)
                     }
                 }
                 
                 self.mapView2.showAnnotations(nearbyAnnotations, animated: true)
             }
         }
         
         // MARK: - Navigation
         
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
             // Get the new view controller using segue.destinationViewController.
             // Pass the selected object to the new view controller.
             if segue.identifier == "showSteps" {
                 let routeTableViewController = segue.destination.children[0] as! RouteTableViewController
                 if let steps = currentRoute?.steps {
                     routeTableViewController.routeSteps = steps
                 }
             }
         }
         
    @IBAction func unwindToMap(segue: UIStoryboardSegue) {
            
        }
    }
