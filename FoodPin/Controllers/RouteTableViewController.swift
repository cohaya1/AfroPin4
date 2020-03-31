//
//  RouteTableViewController.swift
//  FoodPin
//
//  Created by Makaveli Ohaya on 3/30/20.
//  Copyright © 2020 Makaveli Ohaya. All rights reserved.
//
import MapKit
import UIKit

class RouteTableViewController: UITableViewController {
    var routeSteps = [MKRoute.Step]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

     override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }

        // MARK: - Table view data source

        override func numberOfSections(in tableView: UITableView) -> Int {
            // Return the number of sections
            return 1
        }
        
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // Return the number of rows
            return routeSteps.count
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            
            // Configure the cell...
            cell.textLabel?.text = routeSteps[indexPath.row].instructions
            
            return cell
        }

    }
