//
//  LoginFormViewController.swift
//  FoodPin
//
//  Created by Makaveli Ohaya on 5/26/20.
//  Copyright © 2020 Makaveli Ohaya. All rights reserved.
//
import FirebaseAuth
import Firebase
import UIKit

class LoginFormViewController: UIViewController {
   
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    var spinner = UIActivityIndicatorView()
    override func viewDidLoad() {
        super.viewDidLoad()
      setUpElements()
        // Do any additional setup after loading the view.
    }
    func setUpElements() {
        
        // Hide the error label
        errorLabel.alpha = 0
        
        // Style the elements
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(loginButton)
        
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        spinner.style = .gray
        spinner.hidesWhenStopped = true
        view.addSubview(spinner)
        
        // Define layout constraints for the spinner
        spinner.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([ spinner.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150.0),
                                      spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor)])
        
        // Activate the spinner
        spinner.startAnimating()
        
     let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                
                // Signing in the user
                Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                    
                    if error != nil {
                        // Couldn't sign in
                        self.errorLabel.text = error!.localizedDescription
                        self.errorLabel.alpha = 1
                        self.spinner.stopAnimating()
                    }
                    else {
                          self.spinner.stopAnimating()
                        let homeViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController)
                                   self.navigationController?.pushViewController(homeViewController!, animated: true)
                        self.view.window?.rootViewController = homeViewController
                        self.view.window?.makeKeyAndVisible()
                        
                    }
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


