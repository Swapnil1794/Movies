//
//  Color.swift
//  Movie Flix App!
//
//  Created by Swapnil Gavali on 12/06/21.
//

import Foundation
import UIKit
struct Colors {
    
    private static let white = UIColor.white
    private static let black = UIColor.black
    
    public static var backGroundColor: UIColor = {
        if #available(iOS 13, *) {
            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                if UITraitCollection.userInterfaceStyle == .dark {
                    // Return the color for Dark Mode
                    return Colors.black
                } else {
                    // Return the color for Light Mode
                    return Colors.white
                }
            }
        } else {
            // Return a fallback color for iOS 12 and lower.
            return Colors.white
        }
    }()
}
