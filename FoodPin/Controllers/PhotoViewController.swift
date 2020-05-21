//
//  PhotoViewController.swift
//  FoodPin
//
//  Created by Makaveli Ohaya on 5/16/20.
//  Copyright © 2020 Makaveli Ohaya. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
        
        var image:UIImage?
        
        override func viewDidLoad() {
            super.viewDidLoad()

            imageView.image = image
        }

        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        

        // MARK: - Action methods
        
        @IBAction func save(sender: UIButton) {
            guard let imageToSave = image else {
                return
            }
            
            UIImageWriteToSavedPhotosAlbum(imageToSave, nil, nil, nil)
            dismiss(animated: true, completion: nil)
        }

    }
