//
//  LoginViewController.swift
//  FoodPin
//
//  Created by Makaveli Ohaya on 5/25/20.
//  Copyright © 2020 Makaveli Ohaya. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var signUpButton: UIButton!
      
      @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        
    }
    
    func setUpElements() {
           
           Utilities.styleFilledButton(signUpButton)
           Utilities.styleHollowButton(loginButton)
           
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
