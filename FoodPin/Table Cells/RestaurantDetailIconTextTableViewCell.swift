//
//  RestaurantDetailIconTextTableViewCell.swift
//  FoodPin
//
//  Created by Makaveli Ohaya on 1/24/20.
//  Copyright © 2020 Makaveli Ohaya. All rights reserved.
//

import UIKit

class RestaurantDetailIconTextCellTableView: UITableViewCell{
@IBOutlet var  iconimageView: UIImageView!
    
    @IBOutlet var  shorttextLabel: UILabel! {
        didSet {
            shorttextLabel.numberOfLines = 0
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
