//
//  Variation.swift
//  SwiggyAssignment
//
//  Created by Santosh Kumar Sahoo on 7/31/17.
//  Copyright © 2017 Santosh Kumar Sahoo. All rights reserved.
//

import UIKit

/*
 {
 "name":"Thin",
 "price":0,
 "default":1,
 "id":"1",
 "inStock":1
 }
 */
class Variation {
    let name: String?
    let id: String?
    let price: Int?
    let defult: Int?
    let inStock: Int?
    var isOutOfStock: Bool {
        return (inStock ?? 0) == 0
    }
    
    var isSelected = false //if variation is selected then this will be true
    var willDisable = false //User can't select the variation if it is true
    
    init(dictionary:[String:Any]) {
        name = dictionary.getOptionalStringForKey("name")
        id = dictionary.getOptionalStringForKey("id")
        price = dictionary.getOptionalIntForKey("price")
        defult = dictionary.getOptionalIntForKey("default")
        inStock = dictionary.getOptionalIntForKey("inStock")
    }
    
}
