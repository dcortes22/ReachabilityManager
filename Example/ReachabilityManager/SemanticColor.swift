//
//  SemanticColor.swift
//  ReachabilityManager_Example
//
//  Created by David Cortes on 4/21/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

class SemanticColor {
    public static var backgroundTintColor: UIColor {
        if #available(iOS 13, *) {
            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                if UITraitCollection.userInterfaceStyle == .dark {
                    /// Return the color for Dark Mode
                    return UIColor.black
                } else {
                    /// Return the color for Light Mode
                    return UIColor.white
                }
            }
        }else {
            return UIColor.white
        }
    }
    
    public static var labelTintColor: UIColor {
        if #available(iOS 13, *) {
            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                if UITraitCollection.userInterfaceStyle == .dark {
                    /// Return the color for Dark Mode
                    return UIColor.white
                } else {
                    /// Return the color for Light Mode
                    return UIColor.black
                }
            }
        }else {
            return UIColor.white
        }
    }
}
