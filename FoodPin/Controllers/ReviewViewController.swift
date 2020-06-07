//
//  ReviewViewController.swift
//  FoodPin
//
//  Created by Makaveli Ohaya on 3/27/20.
//  Copyright © 2020 Makaveli Ohaya. All rights reserved.
//

import UIKit

protocol ReviewViewControllerDelegate: class {
    func didSelectReview(image: UIImage)
}
class ReviewViewController: UIViewController {
   // var selectiondelegate: SideSelectionDelegate!
    
    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var rateButtons: [UIButton]!
    @IBOutlet var closeButton: UIButton!
    
    weak var delegate: ReviewViewControllerDelegate?
    
    var restaurant: RestaurantMO!
    override func viewDidLoad() {
        super.viewDidLoad()
         if let restaurantImage = restaurant.image {
                   backgroundImageView.image = UIImage(data: restaurantImage as Data)
               }
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
        super.viewWillAppear(animated)
    for index in 0...2 {
        UIView.animate(withDuration: 0.4, delay: (0.1 + 0.05 * Double(index)), options: [], animations: {
            self.rateButtons[index].alpha = 1.0
            self.rateButtons[index].transform = .identity
        }, completion: nil)
    }
    UIView.animate(withDuration: 0.4) {
        self.closeButton.transform = .identity
    }

        

}
    
    @IBAction func rateButtonPressed(sender: UIButton) {
        delegate?.didSelectReview(image: sender.image(for: .normal)!)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func closeButtonPressed(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
