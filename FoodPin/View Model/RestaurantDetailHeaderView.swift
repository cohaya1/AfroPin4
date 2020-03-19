//
//  RestaurantDetailHeaderView.swift
//  FoodPin
//
//  Created by Makaveli Ohaya on 1/22/20.
//  Copyright © 2020 Makaveli Ohaya. All rights reserved.
//

import UIKit

class RestaurantDetailHeaderView: UIView {
    @IBOutlet var HeaderImageView : UIImageView!
    @IBOutlet var nameLabel : UILabel! {
        didSet {
            nameLabel.numberOfLines = 0
        }
    }
    @IBOutlet var typeLabel : UILabel! {
        didSet {
            typeLabel.layer.cornerRadius = 5.0
            typeLabel.layer.masksToBounds = true
        }
    }
    
     @IBOutlet var HeartImageView : UIImageView!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
   
}
