//
//  DiscoverTableViewController.swift
//  FoodPin
//
//  Created by Makaveli Ohaya on 5/13/20.
//  Copyright © 2020 Makaveli Ohaya. All rights reserved.
//

import CloudKit
import UIKit

class DiscoverTableViewController: UITableViewController, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
          
            tableView.reloadData()
        }
    }
    var restaurants: [CKRecord] = []
    var searchResults: [DiscoverTableViewCell] = []
    var spinner = UIActivityIndicatorView()
    var cell = DiscoverTableViewCell()
    var searchController : UISearchController!
    private var imageCache = NSCache<CKRecord.ID, NSURL>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        tableView.cellLayoutMarginsFollowReadableWidth = true
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Configure navigation bar appearance
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        if let customFont = UIFont(name: "Rubik-Medium", size: 40.0) {
            navigationController?.navigationBar.largeTitleTextAttributes = [ NSAttributedString.Key.foregroundColor: UIColor(red: 231, green: 76, blue: 60), NSAttributedString.Key.font: customFont ]
           
            
        }
        searchController = UISearchController(searchResultsController: nil)
        //  self.navigationItem.searchController = searchController
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = NSLocalizedString("Search restaurants...", comment: "Search restaurants...")
        searchController.searchBar.barTintColor = .white
        searchController.searchBar.backgroundImage = UIImage()
        searchController.searchBar.tintColor = UIColor(red: 70, green: 76, blue: 60,alpha: 1.0)
       
        spinner.style = .gray
            spinner.hidesWhenStopped = true
            view.addSubview(spinner)
            
            // Define layout constraints for the spinner
            spinner.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([ spinner.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150.0),
                                          spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor)])
            
            // Activate the spinner
            spinner.startAnimating()
            
            // Pull To Refresh Control
            refreshControl = UIRefreshControl()
            refreshControl?.backgroundColor = UIColor.white
            refreshControl?.tintColor = UIColor.gray
            refreshControl?.addTarget(self, action: #selector(fetchRecordsFromCloud), for: UIControl.Event.valueChanged)
            
            // Fetch records from iCloud
            fetchRecordsFromCloud()
        
        }
     

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return restaurants.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "DiscoverCell", for: indexPath) as! DiscoverTableViewCell
            
            // Configure the cell...
            let restaurant = restaurants[indexPath.row]
            cell.nameLabel.text = restaurant.object(forKey: "name") as? String
            cell.typeLabel.text = restaurant.object(forKey: "type") as? String
//        
        
    cell.phoneLabel.text = restaurant.object(forKey: "phone") as? String
cell.phoneLabel.isUserInteractionEnabled = true
       
        
            cell.locationLabel.text = restaurant.object(forKey: "location") as? String
        
            cell.descriptionLabel.text = restaurant.object(forKey: "description") as? String
            
            // Set the default image
            cell.featuredImageView.image = UIImage(named: "photo")
            
            // Check if the image is stored in cache
            if let imageFileURL = imageCache.object(forKey: restaurant.recordID) {
                // Fetch image from cache
                print("Get image from cache")
                if let imageData = try? Data.init(contentsOf: imageFileURL as URL) {
                    cell.featuredImageView.image = UIImage(data: imageData)
                }
                
            } else {
                // Fetch Image from Cloud in background
                let publicDatabase = CKContainer.default().publicCloudDatabase
                let fetchRecordsImageOperation = CKFetchRecordsOperation(recordIDs: [restaurant.recordID])
                fetchRecordsImageOperation.desiredKeys = ["image"]
                fetchRecordsImageOperation.queuePriority = .veryHigh
                
                fetchRecordsImageOperation.perRecordCompletionBlock = { [unowned self] (record, recordID, error) -> Void in
                    if let error = error {
                        print("Failed to get restaurant image: \(error.localizedDescription)")
                        return
                    }
                    
                    if let restaurantRecord = record,
                        let image = restaurantRecord.object(forKey: "image"),
                        let imageAsset = image as? CKAsset {
                        
                        if let imageData = try? Data.init(contentsOf: imageAsset.fileURL!) {
                            
                            // Replace the placeholder image with the restaurant image
                            DispatchQueue.main.async {
                                cell.featuredImageView.image = UIImage(data: imageData)
                                cell.setNeedsLayout()
                            }
                            
                            // Add the image URL to cache
                            self.imageCache.setObject(imageAsset.fileURL! as NSURL, forKey: restaurant.recordID)
                        }
                    }
                }
                
                publicDatabase.add(fetchRecordsImageOperation)
            }
            
            return cell
        }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
    
    
@objc func fetchRecordsFromCloud() {
        
        // Remove existing records before refreshing
        restaurants.removeAll()
        tableView.reloadData()
        
        // Fetch data using Convenience API
        let cloudContainer = CKContainer.default()
        let publicDatabase = cloudContainer.publicCloudDatabase
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Restaurant", predicate: predicate)
        query.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        // Create the query operation with the query
        let queryOperation = CKQueryOperation(query: query)
        queryOperation.desiredKeys = ["name", "type", "phone", "location", "description"]
        queryOperation.queuePriority = .veryHigh
        queryOperation.resultsLimit = 50
        
        queryOperation.recordFetchedBlock = { (record) -> Void in
            self.restaurants.append(record)
        }
        
        queryOperation.queryCompletionBlock = { [unowned self] (cursor, error) -> Void in
            if let error = error {
                print("Failed to get data from iCloud - \(error.localizedDescription)")
                return
            }
            
            print("Successfully retrieve the data from iCloud")
            DispatchQueue.main.async {
                self.spinner.stopAnimating()
                self.tableView.reloadData()
                
                if let refreshControl = self.refreshControl {
                    if refreshControl.isRefreshing {
                        refreshControl.endRefreshing()
                    }
                }
            }
        }
        
        // Execute the query
        publicDatabase.add(queryOperation)
        
    }
}
