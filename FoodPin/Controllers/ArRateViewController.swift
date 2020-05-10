//
//  ArRateViewController.swift
//  FoodPin
//
//  Created by Makaveli Ohaya on 5/9/20.
//  Copyright © 2020 Makaveli Ohaya. All rights reserved.
//
import ARKit
import SceneKit
import UIKit

class ArRateViewController: UIViewController, ARSCNViewDelegate {
    @IBOutlet weak var EmojiScene: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
   EmojiScene.showsStatistics = true
        let scene = SCNScene(named: "emojiyum.scn")!
        let scene2 = SCNScene(named: "OBJ thinking.scn")!
        // Do any additional setup after loading the view.
        EmojiScene.scene = scene
        EmojiScene.scene = scene2
        EmojiScene.delegate = self
        EmojiScene.debugOptions = [ ARSCNDebugOptions.showFeaturePoints]
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //do world tracking
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        EmojiScene.session.run(configuration)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Pause the scene
        EmojiScene.session.pause()
    
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
