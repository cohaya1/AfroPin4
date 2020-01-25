//
//  RestaurantDetailViewController.swift
//  FoodPin
//
//  Created by Makaveli Ohaya on 1/16/20.
//  Copyright © 2020 Makaveli Ohaya. All rights reserved.
//

import UIKit

class RestaurantDetailViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
   
    
    @IBOutlet var tableview: UITableView!
     @IBOutlet var headerview: RestaurantDetailHeaderView!
    @IBOutlet var restaurantImageView: UIImageView!
    
    var restaurant = Restaurant()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerview.nameLabel.text = restaurant.name
        headerview.typeLabel.text = restaurant.type
        headerview.HeaderImageView.image = UIImage (named: restaurant.image)
       // headerview.HeartImageView.isHidden = (restaurant.isVisited)? false : true
       // Set the table view's delegate and data source
       tableview.delegate = self
              tableview.dataSource = self
    
        navigationItem.largeTitleDisplayMode = .never
        // Do any additional setup after loading the view.
        // Configure the table view's style
        tableview.separatorStyle = .none
    }
     
    func numberOfSections ( in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell  {
        switch indexPath.row {
                   
               case 0:
                   let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RestaurantDetailIconTextCellTableView.self), for: indexPath) as! RestaurantDetailIconTextCellTableView
                   cell.iconimageView.image = UIImage(named: "phone")
                   cell.shorttextLabel.text = restaurant.phone
                   cell.selectionStyle = .none
                   
                   return cell
            
         case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: String( describing: RestaurantDetailIconTextCellTableView.self), for: indexPath) as! RestaurantDetailIconTextCellTableView
                   cell.iconimageView.image = UIImage(named: "map")
                   cell.shorttextLabel.text = restaurant.location
                   cell.selectionStyle = .none
                   
                      return cell
                           case 2:
                               let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RestaurantDetailTextCell.self), for: indexPath) as! RestaurantDetailTextCell
                               cell.DescriptionLabel.text = restaurant.description
                               cell.selectionStyle = .none
                               
                               return cell
                               
                           default:
                               fatalError("Failed to instantiate the table view cell for detail view controller")
                           }
                       }

                   }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


