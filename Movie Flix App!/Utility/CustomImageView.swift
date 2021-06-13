//
//  UIImageView+Extension.swift
//  Movie Flix App!
//
//  Created by Swapnil Gavali on 11/06/21.
//

import Foundation
import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

class CustomImageView : UIImageView {
    
    var imageUrlString:String?
    
    func loadImageUsingUrlString(service:APIServiceProtocol = APIService(),urlString:String)  {
        
        imageUrlString = urlString
        
        image = UIImage(named: "play_tv")
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache.scalePreservingAspectRatio(targetSize: self.bounds.size)
            return
        }
        
        service.fetchImages(url: urlString) { [weak self] data in
            if let data = data {
                DispatchQueue.main.async {
                    let imageToCache = UIImage(data: data)
                    if self?.imageUrlString == urlString {
                        self?.image =  imageToCache!.scalePreservingAspectRatio(targetSize: self!.bounds.size)
                    }
                    imageCache.setObject(imageToCache as AnyObject, forKey: urlString as AnyObject)
                    
                }
                
            }
        }
        
        
    }
    
}

