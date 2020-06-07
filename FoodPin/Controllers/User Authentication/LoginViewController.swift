//
//  LoginViewController.swift
//  FoodPin
//
//  Created by Makaveli Ohaya on 5/25/20.
//  Copyright © 2020 Makaveli Ohaya. All rights reserved.
//

import UIKit
import AVKit
class LoginViewController: UIViewController {
    var videoPlayer:AVPlayer?
       
       var videoPlayerLayer:AVPlayerLayer?
    @IBOutlet weak var signUpButton: UIButton!
      
      @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        
    }
    override func viewWillAppear(_ animated: Bool) {
           
           // Set up video in the background
           setUpVideo()
        
       }
       
    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: "hasViewedWalkthrough") {
            return
        }
        let storyboard = UIStoryboard(name: "OnBoarding", bundle: nil)
        if let walkthroughViewController = storyboard.instantiateViewController(withIdentifier: "WalkthroughViewController") as? WalkthroughViewController {
            
            present(walkthroughViewController, animated: true, completion: nil)
        }
    }
    
    func setUpElements() {
           
           Utilities.styleFilledButton(signUpButton)
           Utilities.styleHollowButton(loginButton)
           
       }
     func setUpVideo() {
            
            // Get the path to the resource in the bundle
            let bundlePath = Bundle.main.path(forResource: "Afro2", ofType: "mp4")
            
            guard bundlePath != nil else {
                return
            }
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(playerItemDidReachEnd(notification:)),
            name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
            object: self.videoPlayer?.currentItem)
            // Create a URL from it
            let url = URL(fileURLWithPath: bundlePath!)
            
            // Create the video player item
            let item = AVPlayerItem(url: url)
            
            // Create the player
            videoPlayer = AVPlayer(playerItem: item)
            
            // Create the layer
            videoPlayerLayer = AVPlayerLayer(player: videoPlayer!)
            
            // Adjust the size and frame
            videoPlayerLayer?.frame = CGRect(x: -self.view.frame.size.width*1.5, y: 0, width: self.view.frame.size.width*4, height: self.view.frame.size.height)
            
            view.layer.insertSublayer(videoPlayerLayer!, at: 0)
            
            // Add it to the view and play it
            videoPlayer?.playImmediately(atRate: 0.3)
        }
    @objc func playerItemDidReachEnd(notification: NSNotification) {
        self.videoPlayer?.seek(to: CMTime.zero)
        self.videoPlayer?.play()
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


