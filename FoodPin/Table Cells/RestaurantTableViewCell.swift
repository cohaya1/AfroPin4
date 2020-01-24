//
//  RestaurantTableViewCell.swift
//  FoodPin
//
//  Created by Makaveli Ohaya on 12/30/19.
//  Copyright © 2019 Makaveli Ohaya. All rights reserved.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var thumbnailImageView: UIImageView! { didSet{
        thumbnailImageView.layer.cornerRadius = 50
        thumbnailImageView.clipsToBounds = true
    }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
