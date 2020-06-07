//
//  AboutTableTableViewController.swift
//  FoodPin
//
//  Created by Makaveli Ohaya on 5/4/20.
//  Copyright © 2020 Makaveli Ohaya. All rights reserved.
//
import FirebaseAuth
import Firebase
import SafariServices
import UIKit

class AboutTableTableViewController: UITableViewController {
   
    var sectionTitles = [NSLocalizedString("Feedback", comment: "Feedback"), NSLocalizedString("Follow Us", comment: "Follow Us")]
    var sectionContent = [[(image: "store", text: NSLocalizedString("Rate us on App Store", comment: "Rate us on App Store"), link: "https://www.apple.com/itunes/charts/paid-apps/"),
                           (image: "chat", text: NSLocalizedString("Tell us your feedback", comment: "Tell us your feedback"), link: "https://websitebuildertailor.responsivesiteeditor.com/home/site/363d88ce/home")],
                          [(image: "twittericon", text: NSLocalizedString("Twitter", comment: "Twitter"), link: "https://twitter.com/Cmarley_chika"),
                           (image: "facebookicon", text: NSLocalizedString("Facebook", comment: "Facebook"), link:
                            "https://www.facebook.com/profile.php?id=100001970751345"),
                           (image: "linkedin", text: NSLocalizedString("Linkedin", comment: "Linkedin"), link: "https://www.linkedin.com/in/cohaya1/")]]
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
               
               tableView.tableFooterView = UIView()
           }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let link = sectionContent[indexPath.section][indexPath.row].link
        
        switch indexPath.section {
        // Leave us feedback section
        case 0:
            if indexPath.row == 0 {
                if let url = URL(string: link) {
                    UIApplication.shared.open(url)
                }
            } else if indexPath.row == 1 {
                performSegue(withIdentifier: "showWebView", sender: self)
            }
        // Follow us section
        case 1:
            if let url = URL(string: link) {
                let safariController = SFSafariViewController(url: url)
                present(safariController, animated: true, completion: nil)
            }
            
        default:
            break
        }
        
        tableView.deselectRow(at: indexPath, animated: false)
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
       return sectionTitles.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
       return sectionContent[section].count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
           return sectionTitles[section]
       }
       
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AboutCell", for: indexPath)
        
        // Configure the cell...
        let cellData = sectionContent[indexPath.section][indexPath.row]
        cell.textLabel?.text = cellData.text
        cell.imageView?.image = UIImage(named: cellData.image)

        return cell
    }
    
    @IBAction func logoutTapped(_ sender: Any) {
        try! Auth.auth().signOut()
        self.dismiss(animated: false)  {
        if self.storyboard != nil {
            self.presentingViewController?.dismiss(animated: false, completion: nil)
                    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ShowLogin") as! UINavigationController
                    self.present(vc, animated: false, completion: nil)
                }
        }
//        if Auth.auth().currentUser != nil {
//                do {
//                    try Auth.auth().signOut()
//                    let homeViewController2 =  UIStoryboard(name: "Main", bundle: nil).self.instantiateViewController(withIdentifier: "ShowLogin")
//                    self.navigationController?.pushViewController(homeViewController2, animated: true)
//                    self.view.window?.rootViewController = homeViewController2
//                    self.view.window?.makeKeyAndVisible()
////                     dismiss(animated: true, completion: {
////                            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController")
////
////
////                        self.present(vc, animated: true, completion: nil)
////                    self.navigationController?.pushViewController(vc, animated: true)
////                    }
//                } catch let error as NSError {
//                    print(error.localizedDescription)
//                }
//            }
        }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "showWebView" {
                if let destinationController = segue.destination as? WebViewController,
                    let indexPath = tableView.indexPathForSelectedRow {
                    
                    destinationController.targetURL = sectionContent[indexPath.section][indexPath.row].link
                }
            }
        }
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


