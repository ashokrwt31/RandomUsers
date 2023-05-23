//
//  UIImageView+Extension.swift
//  RandomUsers
//
//  Created by Ashok Rawat on 23/05/23.
//

import Foundation
import UIKit

extension UIImage {
    
    private static var imageCache = NSCache<NSString, UIImage>()
    
    static func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        // Check if the image is already cached
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            completion(cachedImage)
            return
        }
        
        // Download the image asynchronously
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url),
               let image = UIImage(data: data) {
                // Cache the downloaded image
                imageCache.setObject(image, forKey: url.absoluteString as NSString)
                
                // Return the downloaded image
                DispatchQueue.main.async {
                    completion(image)
                }
            } else {
                // Failed to download the image
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
}
