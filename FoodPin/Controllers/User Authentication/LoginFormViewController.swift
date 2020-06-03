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
    
    @IBOutlet weak var resetpassbutton: UIButton!
    
    var spinner = UIActivityIndicatorView()
    override func viewDidLoad() {
        super.viewDidLoad()
      setUpElements()
        let tap = UIGestureRecognizer(target: self.view,action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    func setUpElements() {
        
        // Hide the error label
        errorLabel.alpha = 0
        
        // Style the elements
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(loginButton)
       
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
            textField.resignFirstResponder()
            
            self.view.endEditing(true)
         return true
        }
        
     
   @IBAction func forgotPasswordTapped(with sender: Any) {
      
        if self.emailTextField.text == "" {
                let alertController = UIAlertController(title: "Oops!", message: "Please enter an email.", preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                
                present(alertController, animated: true, completion: nil)
            
            } else {
            Auth.auth().sendPasswordReset(withEmail: self.emailTextField.text!, completion: { (error) in
                    
                    var title = ""
                    var message = ""
                    
                    if error != nil {
                        title = "Error!"
                        message = (error?.localizedDescription)!
                    } else {
                        title = "Success!"
                        message = "Password reset email sent."
                        self.emailTextField.text = ""
                    }
                    
                    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                })
            }
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


