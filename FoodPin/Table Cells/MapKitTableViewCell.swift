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
    @IBOutlet var mapView: MKMapView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
