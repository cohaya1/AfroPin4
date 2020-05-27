//
//  SignUpViewController.swift
//  FoodPin
//
//  Created by Makaveli Ohaya on 5/25/20.
//  Copyright © 2020 Makaveli Ohaya. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet weak var firstNameTextField: UITextField!
       
       @IBOutlet weak var lastNameTextField: UITextField!
       
       @IBOutlet weak var emailTextField: UITextField!
       
       @IBOutlet weak var passwordTextField: UITextField!
       
       @IBOutlet weak var signUpButton: UIButton!
       
       @IBOutlet weak var errorLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
     setUpElements()
        // Do any additional setup after loading the view.
    }
    func setUpElements() {
       
           // Hide the error label
           errorLabel.alpha = 0
       
           // Style the elements
           Utilities.styleTextField(firstNameTextField)
           Utilities.styleTextField(lastNameTextField)
           Utilities.styleTextField(emailTextField)
           Utilities.styleTextField(passwordTextField)
           Utilities.styleFilledButton(signUpButton)
       }
    
@IBAction func signUpTapped(_ sender: Any) {
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
