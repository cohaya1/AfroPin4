//
//  ReviewViewController.swift
//  FoodPin
//
//  Created by Makaveli Ohaya on 3/27/20.
//  Copyright © 2020 Makaveli Ohaya. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {
    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var rateButtons: [UIButton]!
    @IBOutlet var closeButton: UIButton!
    
    var restaurant = Restaurant()
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundImageView.image = UIImage(named: restaurant.image)
        // Do any additional setup after loading the view.
        // Applying the blur effect
        // Applying the blur effect
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView)
        
        let moveRightTransform = CGAffineTransform.init(translationX: 600, y: 0)
        let scaleUpTransform = CGAffineTransform.init(scaleX: 5.0, y: 5.0)
        let moveScaleTransform = scaleUpTransform.concatenating(moveRightTransform)
        
        // Make the button invisible and move off the screen
        for rateButton in rateButtons {
            rateButton.transform = moveScaleTransform
            rateButton.alpha = 0
    }
        // Move up the closee button
               let moveUpTransform = CGAffineTransform.init(translationX: 0, y: -400)
               closeButton.transform = moveUpTransform
           }
    
    
    override func viewWillAppear(_ animated: Bool) {
    
    for index in 0...2 {
        UIView.animate(withDuration: 0.4, delay: (0.1 + 0.05 * Double(index)), options: [], animations: {
            self.rateButtons[index].alpha = 1.0
            self.rateButtons[index].transform = .identity
        }, completion: nil)
    }
    UIView.animate(withDuration: 0.4) {
        self.closeButton.transform = .identity
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
}
