//
//  MapKitTableViewCell.swift
//  FoodPin
//
//  Created by Makaveli Ohaya on 3/24/20.
//  Copyright © 2020 Makaveli Ohaya. All rights reserved.
//

import UIKit
import MapKit


class MapKitTableViewCell: UITableViewCell {
    @IBOutlet var mapView: MKMapView!{ didSet {
        mapView.layer.cornerRadius = 8.0
        mapView.layer.borderColor = .init(srgbRed: 5.0, green: 0, blue: 0, alpha: 1.0)
        mapView.layer.borderWidth = 0.5
        }}
    @IBOutlet weak var OpenAppleMapsButton : UIButton! { didSet {
    OpenAppleMapsButton.layer.cornerRadius =  5.0
    OpenAppleMapsButton.layer.cornerRadius =  5.0
    OpenAppleMapsButton.layer.borderWidth = 0.5
    OpenAppleMapsButton.layer.borderColor = .init(srgbRed: 5.0, green: 0, blue: 0, alpha: 1.0)
    }}
    
    var detailinfo : RestaurantDetailIconTextCellTableView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func goToAppleMaps(_ sender: UIButton) {
        CLGeocoder().geocodeAddressString((detailinfo.shorttextLabel?.text)!, completionHandler: {(placemarks, error) in

                   if error != nil {
                       print("")
                   } else if placemarks!.count > 0 {
                       let placemark = placemarks![0]
                       let location = placemark.location
                       let coords = location!.coordinate
                       let coordinate = CLLocationCoordinate2DMake(coords.latitude,coords.longitude)
                       let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary:nil))
                       mapItem.name = "Target location"
                       mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])

                   }
               })
           }
    func configure (location: String) {
        //get location
        let geocoder = CLGeocoder()
        
        print(location)
        
        geocoder.geocodeAddressString(location, completionHandler: { placemarks, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let placemarks = placemarks {
                //Get first placemark
                let placemark = placemarks[0]
                //Add Annotation
                let annotation = MKPointAnnotation()
                if let location = placemark.location {
                    // display annotation\
                    annotation.coordinate = location.coordinate; self.mapView.addAnnotation(annotation)
                    //Set the zoom level
                    let region = MKCoordinateRegion( center: annotation.coordinate, latitudinalMeters: 250, longitudinalMeters: 250)
                    self.mapView.setRegion(region, animated: false)
                }
            }
        })
    }
}
