//
//  RestaurantDetailViewController.swift
//  FoodPin
//
//  Created by Makaveli Ohaya on 1/16/20.
//  Copyright © 2020 Makaveli Ohaya. All rights reserved.
//

import UIKit

class RestaurantDetailViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    func numberOfSections ( in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch  indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing : RestaurantDetailIconTextTableViewCell.self),for: indexPath) as! RestaurantDetailIconTextCell
            
        default:
            <#code#>
        }
    }
    
    @IBOutlet var tableview: UITableView!
     @IBOutlet var headerview: RestaurantDetailHeaderView!
    @IBOutlet var restaurantImageView: UIImageView!
    @IBOutlet var restaurantNameLabel: UILabel!
    @IBOutlet var restaurantTypeLabel: UILabel!
    @IBOutlet var restaurantLocationLabel: UILabel!
    var restaurant = Restaurant()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        headerview.nameLabel.text = restaurant.name
        headerview.typeLabel.text = restaurant.type
        headerview.HeaderImageView.image = UIImage (named: restaurant.image)
       // headerview.HeartImageView.isHidden = (restaurant.isVisited)? false : true
        
    
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
