//
//  PhotoManager.swift
//  TumblrBrowser
//
//  Created by Kobsonauta on 23.03.2018.
//  Copyright © 2018 Kobsonauta. All rights reserved.
//

import Foundation
import UIKit

class PhotoManager {

    static let shared = PhotoManager()
    private init() {}

    private var cache = [URL: UIImage]()

    func getPhoto(from url: URL, completion: @escaping ((UIImage?) -> Void)) {
        var image: UIImage? = nil
        if let image = self.cache[url] {

            completion(image)
        } else {

            URLSession.shared.dataTask(with: url, completionHandler: { (data, _, _) -> Void in
                DispatchQueue.main.async(execute: { () -> Void in
                    if let data = data {
                        image = UIImage(data: data)
                        self.cache[url] = image
                        completion(image)
                    } else {
                        completion(nil)
                    }
                })
            }).resume()
        }
    }
}
