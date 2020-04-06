//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by Makaveli Ohaya on 12/26/19.
//  Copyright © 2019 Makaveli Ohaya. All rights reserved.
//

import UIKit

class RestaurantTableViewController: UITableViewController {

    var restaurants: [Restaurant] = [ Restaurant(name: "African Restaurant and Lounge", type: "West African restaurant", location: "6380 GA-85, Riverdale, GA 30274",image:"African Restaurant and Lounge",phone: "(678) 961-5878", description: "Africa Restaurant and Lounge opened in 2008 with the hopes of being the best. We’ve achieved our goal and are now proudly serving many repeat customers. Our customers look to us for great quality and incredible service. We try to deliver on these expectations every time, proudly serving the community. Our unparalleled service, competitive prices, and overall cuisines are why our customers keep returning. We look forward to your patronage.", isVisited: false,rating: ""),
                                      Restaurant(name: "Mina Kitchen", type: "African and Carribean restaurant", location: "5439 Memorial Dr, Stone Mountain, GA 30083",image: "Mina Kitchen", phone:"(404) 297-0470" ,description: "Cozy option serving traditional West African & Caribbean dishes plus beer & wine in a simple cafe.", isVisited: false ),
                                      Restaurant(name: "Moyo & Grill", type: "West African restaurant", location: "5087 Clark Howell Hwy, Atlanta, GA 30349",image: "Moyo & Grill", phone:"(404) 903-4650",description: "Not available Yet", isVisited: false ),
         Restaurant(name: "FAD African Fine Dining Restaurant ", type: "Nigerian/African restaurant", location: "3565 Austell Rd SW #1061, Marietta, GA 30008", image: "African Fine Dining Restaurant", phone: "(770) 431-8505" , description: "Fad Fine Dining Restaurant is a family owned and operated business. We are driven by our love of good food and enjoy sharing that food with our friends and family. Our philosophy is that a successful party has not only good food but also good service. FAD Catering Service provide outside catering for a variety of events", isVisited: false),
         Restaurant(name: "224 West African Cuisine", type: "West African restaurant & Bar", location: "5151 W Fayetteville Rd, Atlanta, GA 30349", image: "224 West African Cuisine", phone:"(770) 892-5940",description: "Informal restaurant offering hearty plates of West African comfort food & a full bar.", isVisited: false),
         Restaurant(name: "Tropicana African Restaurant", type: "African Restaurant", location: "2055 Flat Shoals Rd, Riverdale, GA 30296",image: "Tropicana African Restaurant", phone:"(770) 629-4783",description: "Coming Soon", isVisited: false),
         Restaurant(name: "Bamba Cuisine", type: "African restaurant", location: "3700 Campbellton Rd SW suite1, Atlanta, GA 30311",image: "Bamba Cuisine", phone: "(678) 705-9683",description:" We are a West African restaurant specializing in Senegalese cuisine. After almost 20 years serving the community, we have taken a significant part in transforming our restaurant and environment into a Taste of Senegal.  Each of our customers have the opportunity to join in at our table as family and fest in our traditional dishes.​", isVisited: false),
         Restaurant(name: "Senegambia Restaurant", type: "West African restaurant", location: "2180 Campbellton Rd SW, Atlanta, GA 30311",image: "Senegambia Restaurant", phone:"(404) 500-2835",description:"Coming Soon!", isVisited: false),
         Restaurant(name: "Ty-lexine Cuisine", type: "West African restaurant", location: "8558 Tara Blvd, Jonesboro, GA 30236", image: "Ty-lexine Cuisine",phone:"(678) 489-3185",description:"Tylexine Cuisine is a restaurant located in Joneboro, Georgia, that serves food from west African countries like Liberia, Nigeria, Ghana, and more." ,isVisited: false)
    ]
    var restaurantIsVisited = Array(repeating: false, count: 10)
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.cellLayoutMarginsFollowReadableWidth = true
        //Makes Navigation title larger
        navigationController?.navigationBar.prefersLargeTitles = true
        // Customize the navigation bar
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        if let customFont = UIFont(name: "Rubik-Medium", size: 40.0) {
            navigationController?.navigationBar.largeTitleTextAttributes = [ NSAttributedString.Key.foregroundColor: UIColor(red: 231.0/255.0, green: 76.0/255.0, blue: 60.0/255.0, alpha: 1.0), NSAttributedString.Key.font: customFont ]
            //Hides nav bar on swipe
            navigationController?.hidesBarsOnSwipe = true
        }
  //      navigationController?.hidesBarsOnSwipe = true

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
           let cellIdentifier = "datacell"
           let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantTableViewCell
   
           // Configure the cell...
   
    cell.nameLabel.text = restaurants[indexPath.row].name
   cell.thumbnailImageView.image = UIImage(named: restaurants[indexPath.row].image)
   cell.locationLabel.text = restaurants[indexPath.row].location
   cell.typeLabel.text = restaurants[indexPath.row].type
           
          
   cell.accessoryType = restaurants[indexPath.row].isVisited ? .checkmark : .none
           
           
           // Use the isHidden property to control the appearance of the heart icon
       //    cell.heartImageView.isHidden = restaurantIsVisited[indexPath.row] ? false : true
           
           return cell
       }
       
        
        // MARK: - Table view delegate
    override func numberOfSections(in tableView: UITableView) -> Int {
               return 1
           }

           override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
               return restaurants.count
           }
           /*
            override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                
                // Create an option menu as an action sheet
                let optionMenu = UIAlertController(title: nil, message: "What do you want to do?", preferredStyle: .actionSheet)
                
                if let popoverController = optionMenu.popoverPresentationController {
                    if let cell = tableView.cellForRow(at: indexPath) {
                        popoverController.sourceView = cell
                        popoverController.sourceRect = cell.bounds
                    }
                }
                
                // Add actions to the menu
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                optionMenu.addAction(cancelAction)
                
                // Add Call action
                let callActionHandler = { (action:UIAlertAction!) -> Void in
                    let alertMessage = UIAlertController(title: "Service Unavailable", message: "Sorry, the call feature is not available yet. Please retry later.", preferredStyle: .alert)
                    alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alertMessage, animated: true, completion: nil)
                }
                
                let callAction = UIAlertAction(title: "Call " + "123-000-\(indexPath.row)", style: .default, handler: callActionHandler)
                optionMenu.addAction(callAction)
                
                
                // Determine the action tile by examining the status of restaurantIsVisited[indexPath.row]
                // If it is set to true, we set the title "Undo Check in".
                
                let checkActionTitle = (restaurantIsVisited[indexPath.row]) ? "Undo Check in" : "Check in"
                
                Check-in action
                let checkInAction = UIAlertAction(title: checkActionTitle, style: .default, handler: {
                    (action:UIAlertAction!) -> Void in
                    
                    let cell = tableView.cellForRow(at: indexPath) as! RestaurantTableViewCell
                    
                    self.restaurantIsVisited[indexPath.row] = (self.restaurantIsVisited[indexPath.row]) ? false : true
                    
                    
                    // ---
                    // Toggle the accessoryType and the value of restaurantIsVisited[indexPath.row]
                    // If the value of self.restaurantIsVisited[indexPath.row] is true, we set the accessory type to .none.
                    
                    cell.accessoryType =  .checkmark
                    
                    // Solution to exercise #2
                    // ---
                    // Use the isHidden property to control the appearance of the heart icon
                    
                 cell.ImageView.isHidden = self.restaurantIsVisited[indexPath.row] ? false : true
                    if self.restaurantIsVisited[indexPath.row] {
                      cell.accessoryType =  .checkmark
                    }
                    else {
                        cell.accessoryType = .none
                    }
                    
                    
                })
                optionMenu.addAction(checkInAction)
                
                // Display the menu
                present(optionMenu, animated: true, completion: nil)
                
                // Deselect the row
                tableView.deselectRow(at: indexPath, animated: false)
            }
        */

        


        /*
        // Override to support conditional editing of the table view.
        override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            // Return false if you do not want the specified item to be editable.
            return true
        }
        */
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = true
    }
        
        // Override to support editing the table view.
        override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            let deleteaction = UIContextualAction(style: .destructive, title: "Delete"){
                (action,sourceView, completionHandler) in
                // delete row from datasource
                self.restaurants.remove(at: indexPath.row)
                
                self.tableView.deleteRows(at: [indexPath], with:.fade)
                //Call completion handler to dismiss action button
                completionHandler(true)
    }
           let shareAction = UIContextualAction(style: .normal, title: "Share") { (action, sourceView, completionHandler) in

            let defaultText = "Just checking in at " + self.restaurants[indexPath.row].name
                    
                
                let activityController: UIActivityViewController
                
               if let imageToShare = UIImage(named: self.restaurants[indexPath.row].image) {
                                    activityController = UIActivityViewController(activityItems: [defaultText, imageToShare], applicationActivities: nil)
                                } else  {
                                    activityController = UIActivityViewController(activityItems: [defaultText], applicationActivities: nil)
                                }
                                
                                if let popoverController = activityController.popoverPresentationController {
                                    if let cell = tableView.cellForRow(at: indexPath) {
                                        popoverController.sourceView = cell
                                        popoverController.sourceRect = cell.bounds
                                    }
                                }
                                
                                self.present(activityController, animated: true, completion: nil)
                                completionHandler(true)
                            }
                            
                            // Set the icon and background color for the actions
                            deleteaction.backgroundColor = UIColor(red: 231.0/255.0, green: 76.0/255.0, blue: 60.0/255.0, alpha: 1.0)
                            deleteaction.image = UIImage(named: "delete")
                            
                            shareAction.backgroundColor = UIColor(red: 254.0/255.0, green: 149.0/255.0, blue: 38.0/255.0, alpha: 1.0)
                            shareAction.image = UIImage(named: "share")
                            
                            let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteaction, shareAction])
                            
                            return swipeConfiguration
                        }
                        
                        override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
                            
                            let checkInAction = UIContextualAction(style: .normal, title: "Check-in") { (action, sourceView, completionHandler) in
                                
                                _ = tableView.cellForRow(at: indexPath) as! RestaurantTableViewCell
                                self.restaurants[indexPath.row].isVisited = (self.restaurants[indexPath.row].isVisited) ? false : true
                             //   cell.ImageView.isHidden = self.restaurantIsVisited[indexPath.row] ? false : true
                                
                                completionHandler(true)
                            }
                            
                            let checkInIcon = restaurants[indexPath.row].isVisited ? "undo" : "tick"
                            checkInAction.backgroundColor = UIColor(red: 38.0/255.0, green: 162.0/255.0, blue: 78.0/255.0, alpha: 1.0)
                            checkInAction.image = UIImage(named: checkInIcon)
                            
                            let swipeConfiguration = UISwipeActionsConfiguration(actions: [checkInAction])
                            
                            
                            return swipeConfiguration
                }
    
    @IBAction func unwindTOHome ( segue:UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
                     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                            if segue.identifier == "ShowRestaurantDetails" {
                                if let indexPath = tableView.indexPathForSelectedRow {
                                    let destinationController = segue.destination as! RestaurantDetailViewController
                                    destinationController.restaurant = restaurants[indexPath.row]
                                    
                                }
                            }
                        }
                    }

    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */



