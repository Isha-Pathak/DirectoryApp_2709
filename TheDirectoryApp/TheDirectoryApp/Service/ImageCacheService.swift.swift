//
//  ImageCacheService.swift.swift
//  TheDirectoryApp
//
//  Created by isha pathak on 28/07/22.
//

import Foundation
import UIKit

class ImageCacheService {

    static let cache = NSCache<NSString, UIImage>()

    // MARK: downloadImage function to load the image first time and save it to cache
    static func downloadImage(withURL url:URL, completion: @escaping (_ image:UIImage?)->()) {
        let dataTask = URLSession.shared.dataTask(with: url) { data, responseURL, error in
            var downloadedImage:UIImage?
            if let data = data {
                downloadedImage = UIImage(data: data)
            }

            if downloadedImage != nil {
                cache.setObject(downloadedImage!, forKey: url.absoluteString as NSString)
            }
            DispatchQueue.main.async {
                completion(downloadedImage)
            }
        }
        dataTask.resume()
    }

    // MARK: getImage function to check if image exists in the cache else download
    static func getImage(withURL url:URL, completion: @escaping (_ image:UIImage?)->()) {
        if let image = cache.object(forKey: url.absoluteString as NSString) {
            completion(image)
        } else {
            downloadImage(withURL: url, completion: completion)
        }
    }
}
