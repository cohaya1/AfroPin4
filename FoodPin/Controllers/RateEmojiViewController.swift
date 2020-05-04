//
//  RateEmojiViewController.swift
//  FoodPin
//
//  Created by Makaveli Ohaya on 4/29/20.
//  Copyright © 2020 Makaveli Ohaya. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import RealityKit

class RateEmojiViewController: UIViewController, ARSCNViewDelegate{
@IBOutlet var sceneView: ARSCNView!
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate = self
        // Do any additional setup after loading the view.
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
