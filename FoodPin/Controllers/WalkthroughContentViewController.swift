//
//  WalkthroughContentViewController.swift
//  FoodPin
//
//  Created by Makaveli Ohaya on 5/3/20.
//  Copyright © 2020 Makaveli Ohaya. All rights reserved.
//

import UIKit

class WalkthroughContentViewController: UIViewController {

  @IBOutlet var headingLabel: UILabel! {
            didSet {
                headingLabel.numberOfLines = 0
            }
        }
        @IBOutlet var subHeadingLabel: UILabel! {
            didSet {
                subHeadingLabel.numberOfLines = 0
            }
        }
        @IBOutlet var contentImageView: UIImageView!

        var index = 0
        var heading = ""
        var subHeading = ""
        var imageFile = ""
        
        override func viewDidLoad() {
            super.viewDidLoad()

            headingLabel.text = heading
            subHeadingLabel.text = subHeading
            contentImageView.image = UIImage(named: imageFile)
        }
        

    }
