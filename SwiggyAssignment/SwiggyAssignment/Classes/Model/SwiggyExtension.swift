//
//  SwiggyExtension.swift
//  SwiggyAssignment
//
//  Created by Santosh Kumar Sahoo on 8/1/17.
//  Copyright © 2017 Santosh Kumar Sahoo. All rights reserved.
//

import UIKit

extension Dictionary {
    
    func getOptionalStringForKey(_ key: Key) -> String? {
        if let stringValue = self[key] as? String {
            return stringValue
        }
        if let intValue = getOptionalIntForKey(key) {
            return String(intValue)
        }
        return nil
    }
    
    func getOptionalIntForKey(_ key: Key) -> Int? {
        if let y = self[key] as? Int {
            return y
        }
        if let strValue = getOptionalStringForKey(key) {
            return Int(strValue)
        }
        return nil
    }
}

extension UIColor {
    
    class func selectedColor() -> UIColor {
        return UIColor.init(colorLiteralRed: 0/235, green: 185/235, blue: 245/235, alpha: 1)
    }
}
