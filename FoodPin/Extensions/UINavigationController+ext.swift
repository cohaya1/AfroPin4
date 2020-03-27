//
//  UINavigationController+ext.swift
//  FoodPin
//
//  Created by Makaveli Ohaya on 3/23/20.
//  Copyright © 2020 Makaveli Ohaya. All rights reserved.
//
import UIKit
import Foundation

extension UINavigationController {
    open override var childForStatusBarStyle: UIViewController?{
        return topViewController
    }
}
