//
//  Bundle.swift
//  Unknown
//
//  Created by sean on 2022/09/23.
//

import Foundation

extension Bundle{
    var apiKey: String {
        guard let file = self.path(forResource: "ENV", ofType: "plist") else { return "" }
        
        guard let resource = NSDictionary(contentsOfFile: file) else { return "" }
        guard let key = resource["API_KEY"] as? String else { fatalError("Please set API Key to ENV.plist")}
        return key
      }
}
