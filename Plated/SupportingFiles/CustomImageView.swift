//
//  CustomImageView.swift
//  Plated
//
//  Created by User on 8/3/19.
//  Copyright © 2019 Jonathan King. All rights reserved.
//

import UIKit

//var imageCache = [String: UIImage]()
let imageCache = NSCache<AnyObject, AnyObject>()

class CustomImageView: UIImageView {
    
    var lastURLUsedToLoadImage: String?
    
    func loadImage(with urlString: String) {
        
        lastURLUsedToLoadImage = urlString
        
        self.image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            if url.absoluteString != self.lastURLUsedToLoadImage {
                return
            }
            
            guard let imageData = data else { return }
            guard let imageToCache = UIImage(data: imageData, scale: UIScreen.main.scale) else { return }
            imageCache.setObject(imageToCache, forKey: urlString as AnyObject)
            
            DispatchQueue.main.async {
                UIView.transition(with: self,
                                  duration: 0.2,
                                  options: .transitionCrossDissolve,
                                  animations: { self.image = imageToCache },
                                  completion: { (_) in
                                    // nil for now
                })
            }
            }.resume()
    }
    
}
