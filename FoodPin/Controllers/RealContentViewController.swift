//
//  RealContentViewController.swift
//  FoodPin
//
//  Created by Makaveli Ohaya on 5/10/20.
//  Copyright © 2020 Makaveli Ohaya. All rights reserved.
//
import SwiftUI
import UIKit


class RealContentViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
                     
let newView = UIHostingController(rootView: ContentView())
        navigationController?.pushViewController(newView, animated: true)
         navigationController?.setNavigationBarHidden(true, animated: true)
        navigationController?.setToolbarHidden(true, animated: true)
        
        
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
