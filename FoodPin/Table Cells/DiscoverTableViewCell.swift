//
//  DiscoverTableViewCell.swift
//  FoodPin
//
//  Created by Makaveli Ohaya on 5/13/20.
//  Copyright © 2020 Makaveli Ohaya. All rights reserved.
//
import MapKit
import UIKit

class DiscoverTableViewCell: UITableViewCell {
@IBOutlet weak var phonebutton : UIButton!
    @IBOutlet weak var mapbutton : UIButton!
    @IBOutlet weak var nameLabel: UILabel! {
            didSet {
                nameLabel.numberOfLines = 0
                nameLabel.layer.borderColor = .init(srgbRed: 5.0, green: 0, blue: 0, alpha: 1.0)
            }
        }
    @IBOutlet weak var phoneLabel: UILabel!
        @IBOutlet weak var typeLabel: UILabel!
        @IBOutlet weak var locationLabel: UILabel! {
            didSet {
                //goToMaps(locationLabel)
                locationLabel.numberOfLines = 0
            }
        }
    @IBAction func callNumber(_ sender: UIButton) {
       if let url = URL(string: "tel://\(phoneLabel.text!)"),
        UIApplication.shared.canOpenURL(url) {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    }
     @IBAction func goToMaps(_ sender: UIButton) {
        CLGeocoder().geocodeAddressString((locationLabel?.text)!, completionHandler: {(placemarks, error) in

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

    
//    @IBOutlet var phoneLabel: UILabel!
    
        @IBOutlet var descriptionLabel: UILabel! {
            didSet {
                descriptionLabel.numberOfLines = 0
                descriptionLabel.layer.borderColor = .init(srgbRed: 5.0, green: 0, blue: 0, alpha: 1.0)
            }
        }
        @IBOutlet weak var featuredImageView: UIImageView! {
            didSet {
                featuredImageView.contentMode = .scaleAspectFill
                featuredImageView.clipsToBounds = true
              featuredImageView.layer.cornerRadius =  7.0
               featuredImageView.layer.borderWidth = 0.5
                featuredImageView.layer.borderColor = .init(srgbRed: 5.0, green: 0, blue: 0, alpha: 1.0)
                let blurEffect = UIBlurEffect(style: .dark)
                let blurredEffectView = UIVisualEffectView(effect: blurEffect)
                blurredEffectView.frame = featuredImageView.bounds
               
            }
        }
        
        override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
            
            self.selectionStyle = .none
        }

        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)

            // Configure the view for the selected state
        }

    }
