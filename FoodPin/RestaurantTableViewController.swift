//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by Makaveli Ohaya on 12/26/19.
//  Copyright © 2019 Makaveli Ohaya. All rights reserved.
//

import UIKit

class RestaurantTableViewController: UITableViewController {

    var restaurantnames = ["African Restaurant and Lounge", "Mina Kitchen", "Moyo & Grill", "African Fine Dining Restaurant", "224 West African Cuisine","Tropicana African Restaurant","Bamba Cuisine","Senegambia Restaurant","Ty-lexine Cuisine"]
    var restaurantimages = ["African Restaurant and Lounge", "Mina Kitchen", "Moyo & Grill", "African Fine Dining Restaurant", "224 West African Cuisine","Tropicana African Restaurant","Bamba Cuisine","Senegambia Restaurant","Ty-lexine Cuisine"]
    var restaurantlocation = ["Riverdale, GA", "5439 Memorial Dr, Stone Mountain, GA 30083","5087 Clark Howell Hwy, Atlanta, GA 30349","3565 Austell Rd SW #1061, Marietta, GA 30008","5151 W Fayetteville Rd, Atlanta, GA 30349","2055 Flat Shoals Rd, Riverdale, GA 30296","3700 Campbellton Rd SW suite1, Atlanta, GA 30311","2180 Campbellton Rd SW, Atlanta, GA 30311","8558 Tara Blvd, Jonesboro, GA 30236"]
    var restauranttype = [ "West African restaurant","African and Carribean restaurant","West African restaurant","African restaurant","West African restaurant & Bar","African Restaurant", "African restaurant","West African restaurant","West African restaurant"]
    var restaurantIsVisited = Array(repeating: false, count: 10)
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.cellLayoutMarginsFollowReadableWidth = true
        //Makes Navigation title larger
        navigationController?.navigationBar.prefersLargeTitles = true

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cellIdentifier = "datacell"
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantTableViewCell
    
            // Configure the cell...
    
            cell.nameLabel.text = restaurantnames[indexPath.row]
            cell.thumbnailImageView.image = UIImage(named: restaurantimages[indexPath.row])
            cell.locationLabel.text = restaurantlocation[indexPath.row]
            cell.typeLabel.text = restauranttype[indexPath.row]
            
            // Solution to Exercise #1
    cell.accessoryType = restaurantIsVisited[indexPath.row] ? .checkmark : .none
            
            // Solution to Exercise #2
            // Use the isHidden property to control the appearance of the heart icon
        //    cell.heartImageView.isHidden = restaurantIsVisited[indexPath.row] ? false : true
            
            return cell
        }
        
        // MARK: - Table view delegate
    override func numberOfSections(in tableView: UITableView) -> Int {
           return 1
       }

       override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return restaurantnames.count
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
            
            // Solution to exercise #1
            // ---
            // Determine the action tile by examining the status of restaurantIsVisited[indexPath.row]
            // If it is set to true, we set the title "Undo Check in".
            
            let checkActionTitle = (restaurantIsVisited[indexPath.row]) ? "Undo Check in" : "Check in"
            
            // Check-in action
            let checkInAction = UIAlertAction(title: checkActionTitle, style: .default, handler: {
                (action:UIAlertAction!) -> Void in
                
                let cell = tableView.cellForRow(at: indexPath) as! RestaurantTableViewCell
                
                self.restaurantIsVisited[indexPath.row] = (self.restaurantIsVisited[indexPath.row]) ? false : true
                
                // Solution to exercise #1
                // ---
                // Toggle the accessoryType and the value of restaurantIsVisited[indexPath.row]
                // If the value of self.restaurantIsVisited[indexPath.row] is true, we set the accessory type to .none.
                
                cell.accessoryType =  .checkmark
                
                // Solution to exercise #2
                // ---
                // Use the isHidden property to control the appearance of the heart icon
                
       //      cell.ImageView.isHidden = self.restaurantIsVisited[indexPath.row] ? false : true
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

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteaction = UIContextualAction(style: .destructive, title: "Delete"){
            (action,sourceView, completionHandler) in
            // delete row from datasource
            self.restaurantnames.remove(at: indexPath.row)
            self.restaurantimages.remove(at: indexPath.row)
            self.restaurantlocation.remove(at: indexPath.row)
            self.restaurantIsVisited.remove(at: indexPath.row)
            self.restauranttype.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with:.fade)
            //Call completion handler to dismiss action button
            completionHandler(true)
}
       let shareAction = UIContextualAction(style: .normal, title: "Share") { (action, sourceView, completionHandler) in
                let defaultText = "Just checking in at " + self.restaurantnames[indexPath.row]
                
                let activityController: UIActivityViewController
                
                if let imageToShare = UIImage(named: self.restaurantimages[indexPath.row]) {
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
                
                let cell = tableView.cellForRow(at: indexPath) as! RestaurantTableViewCell
                self.restaurantIsVisited[indexPath.row] = (self.restaurantIsVisited[indexPath.row]) ? false : true
             //   cell.ImageView.isHidden = self.restaurantIsVisited[indexPath.row] ? false : true
                
                completionHandler(true)
            }
            
            let checkInIcon = restaurantIsVisited[indexPath.row] ? "undo" : "tick"
            checkInAction.backgroundColor = UIColor(red: 38.0/255.0, green: 162.0/255.0, blue: 78.0/255.0, alpha: 1.0)
            checkInAction.image = UIImage(named: checkInIcon)
            
            let swipeConfiguration = UISwipeActionsConfiguration(actions: [checkInAction])
            
            
            return swipeConfiguration
}
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "ShowRestaurantDetails" {
                if let indexPath = tableView.indexPathForSelectedRow {
                    let destinationController = segue.destination as! RestaurantDetailViewController
                    destinationController.restaurantImagename = restaurantimages[indexPath.row]
                    destinationController.restaurantName = restaurantnames[indexPath.row]
                    destinationController.restaurantType = restauranttype[indexPath.row]
                    destinationController.restaurantLocation = restaurantlocation[indexPath.row]
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



