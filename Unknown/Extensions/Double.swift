//
//  Double.swift
//  Unknown
//
//  Created by sean on 2022/09/27.
//

import Foundation

extension Double{
    
    /// transform Double Value to 2 digits String value
    /// ```
    /// Converts 6.2928 -> 6.29
    /// ```
    func asNumberString() -> String{
        
        return String(format: "%.2f", self)
        
    }
}
