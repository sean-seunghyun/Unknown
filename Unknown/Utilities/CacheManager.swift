//
//  CacheManager.swift
//  Unknown
//
//  Created by sean on 2022/09/29.
//

import Foundation
import SwiftUI

class CacheManager{
    
    var cache: NSCache<NSString, UIImage> = {
        var cache = NSCache<NSString, UIImage>()
        cache.countLimit = 200
        cache.totalCostLimit = 1024 * 1024 * 200 // 200mb
        
        return cache
    }()
    
    static let instance = CacheManager()
    
    private init() { }
    
    func add(key: String, image: UIImage){
        cache.setObject(image, forKey: key as NSString)
    }
    
    func get(key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
    
    
}
