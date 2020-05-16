//
//  DiscoverTableViewCell.swift
//  FoodPin
//
//  Created by Makaveli Ohaya on 5/13/20.
//  Copyright © 2020 Makaveli Ohaya. All rights reserved.
//

import UIKit

class DiscoverTableViewCell: UITableViewCell {
@IBOutlet weak var phonebutton : UIButton!
    @IBOutlet weak var nameLabel: UILabel! {
            didSet {
                nameLabel.numberOfLines = 0
            }
        }
        @IBOutlet weak var typeLabel: UILabel!
        @IBOutlet weak var locationLabel: UILabel! {
            didSet {
                locationLabel.numberOfLines = 0
            }
        }
    @IBOutlet var phoneLabel: UILabel!
    
        @IBOutlet var descriptionLabel: UILabel! {
            didSet {
                descriptionLabel.numberOfLines = 0
            }
        }
        @IBOutlet weak var featuredImageView: UIImageView! {
            didSet {
                featuredImageView.contentMode = .scaleAspectFill
                featuredImageView.clipsToBounds = true
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
