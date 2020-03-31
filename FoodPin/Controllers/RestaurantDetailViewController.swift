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
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
         navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .white
       // disable nav bar on swipe only for detailed view
        navigationController?.hidesBarsOnSwipe = false
        // adjust contect view to cover safe area code
        tableview.contentInsetAdjustmentBehavior = .never
        
        headerview.nameLabel.text = restaurant.name
        headerview.typeLabel.text = restaurant.type
        headerview.HeaderImageView.image = UIImage (named: restaurant.image)
       //headerview.HeartImageView.isHidden = (restaurant.isVisited)? false : true
       // Set the table view's delegate and data source
       tableview.delegate = self
              tableview.dataSource = self
    
        navigationItem.largeTitleDisplayMode = .never
        // Do any additional setup after loading the view.
        // Configure the table view's style
        tableview.separatorStyle = .none
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
     
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    func numberOfSections ( in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    override func prepare( for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMap" {
            let destinationcontroller = segue.destination as! MapViewController; destinationcontroller.restaurant = restaurant
        }
       else if segue.identifier == "showReview" {
            let destinationcontroller = segue.destination as! ReviewViewController; destinationcontroller.restaurant = restaurant
        }
        
    }
    @IBAction func close (segue: UIStoryboardSegue) {
       dismiss(animated: true, completion: nil)
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
                               
            case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: String( describing: SeparatorTableViewCell.self), for: indexPath) as! SeparatorTableViewCell
            cell.titleLabel.text = "HOW DO I GET HERE"
            
            cell.selectionStyle = .none
            return cell
            
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: String( describing: MapKitTableViewCell.self), for: indexPath) as! MapKitTableViewCell
            cell.configure(location: restaurant.location)
        cell.selectionStyle = .none
        return cell
                           default:
                               fatalError("Failed to instantiate the table view cell for detail view controller")
       
        
            
                           }
                       }
    @IBAction func rateRestaurant(segue: UIStoryboardSegue) {
        dismiss(animated: true, completion: {
            if let rating = segue.identifier {
                self.restaurant.rating = rating
                
                self.headerview.RatingImageView.image = UIImage(named: rating)
                
                let scaleTransform = CGAffineTransform.init(scaleX: 0.1, y: 0.1)
                self.headerview.RatingImageView.transform = scaleTransform
                self.headerview.RatingImageView.alpha = 0
                
                UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.7, options: [], animations: {
                    self.headerview.RatingImageView.transform = .identity
                    self.headerview.RatingImageView.alpha = 1
                }, completion: nil)
            }
        })
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


