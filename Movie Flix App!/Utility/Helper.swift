//
//  Helper.swift
//  SKYCORE
//
//  Created by Swapnil Gavali on 07/01/21.
//

import Foundation
import UIKit

class Helper: NSObject {
    class func getBundle() -> Bundle? {
        return Bundle(identifier: Constants.BUNDLE_ID)
    }
    
    class func presentAlert(on viewController:UIViewController,title:String,message:String)  {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Constants.OK, style: .default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
    
   
    
}

