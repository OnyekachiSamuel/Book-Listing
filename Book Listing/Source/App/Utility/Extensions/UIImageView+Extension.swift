//
//  UIImageView+Extension.swift
//  Book Listing
//
//  Created by Onyekachi Ezeoke on 02/04/2020.
//  Copyright © 2020 Onyekachi Ezeoke. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    func loadImage(from url: URL?) {
        guard let url = url else { return }
        if let imageFromCache = imageCache.object(forKey: url.absoluteString as NSString) {
            self.image = imageFromCache
            return
        }
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        imageCache.setObject(image, forKey: url.absoluteString as NSString)
                        self.image = image
                    }
                }
            }
        }
    }
}
