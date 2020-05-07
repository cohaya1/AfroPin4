//
//  RateEmojiViewController.swift
//  FoodPin
//
//  Created by Makaveli Ohaya on 4/29/20.
//  Copyright © 2020 Makaveli Ohaya. All rights reserved.
//

import UIKit

import RealityKit

class RateEmojiViewController: UIViewController {

    @IBOutlet  var arView : ARView!
   
    var emojianchor: Emoji.SceneEmoji!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       emojianchor = try! Emoji.loadSceneEmoji()
        emojianchor.generateCollisionShapes(recursive: true)
         arView.scene.anchors.append(emojianchor)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func StartExperience(_ sender: Any) {
        emojianchor.notifications.startEmoji.post()
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
