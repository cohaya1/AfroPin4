//
//  RestaurantDetailViewController.swift
//  FoodPin
//
//  Created by Makaveli Ohaya on 1/16/20.
//  Copyright © 2020 Makaveli Ohaya. All rights reserved.
//

import UIKit

class RestaurantDetailViewController: UIViewController {

    @IBOutlet var restaurantImageView: UIImageView!
    @IBOutlet var restaurantNameLabel: UILabel!
    @IBOutlet var restaurantTypeLabel: UILabel!
    @IBOutlet var restaurantLocationLabel: UILabel!
    var restaurant = Restaurant()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        restaurantImageView.image = UIImage(named: restaurantImagename)
        restaurantNameLabel.text = restaurantName
        restaurantTypeLabel.text = restaurantType
        restaurantLocationLabel.text = restaurantLocation
        */
        
        navigationItem.largeTitleDisplayMode = .never
        // Do any additional setup after loading the view.
    }
     
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
