//
//  WalkthroughViewController.swift
//  FoodPin
//
//  Created by Makaveli Ohaya on 5/3/20.
//  Copyright © 2020 Makaveli Ohaya. All rights reserved.
//

import UIKit

class WalkthroughViewController: UIViewController,WalkthroughPageViewControllerDelegate {
    @IBOutlet var pageControl: UIPageControl!
       @IBOutlet var nextButton: UIButton! {
           didSet {
               nextButton.layer.cornerRadius = 25.0
               nextButton.layer.masksToBounds = true
           }
       }
       @IBOutlet var skipButton: UIButton!
 var walkthroughPageViewController: WalkthroughPageViewController?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func skipButtonTapped(sender: UIButton) {
      //     UserDefaults.standard.set(true, forKey: "hasViewedWalkthrough")
           dismiss(animated: true, completion: nil)
       }
    @IBAction func nextButtonTapped(sender: UIButton) {
           
           if let index = walkthroughPageViewController?.currentIndex {
               switch index {
               case 0...1:
                   walkthroughPageViewController?.forwardPage()
                   
               case 2:
                   UserDefaults.standard.set(true, forKey: "hasViewedWalkthrough")
                   dismiss(animated: true, completion: nil)
                   
               default: break
                   
               }
           }
           
           updateUI()
       }

   func updateUI() {

            if let index = walkthroughPageViewController?.currentIndex {
                switch index {
                case 0...1:
                    nextButton.setTitle("NEXT", for: .normal)
                    skipButton.isHidden = false
                case 2:
                    nextButton.setTitle("GET STARTED", for: .normal)
                    skipButton.isHidden = true
                default: break
                }
                
                pageControl.currentPage = index
            }
            
        }
        
        // MARK: - Navigation
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let destination = segue.destination
            if let pageViewController = destination as? WalkthroughPageViewController {
                walkthroughPageViewController = pageViewController
                walkthroughPageViewController?.walkthroughDelegate = self
            }
        }
        
        // MARK: - WalkthroughPageViewControllerDelegate method
        
        func didUpdatePageIndex(currentIndex: Int) {
            updateUI()
        }
    }
