//
//  VariantGroup.swift
//  SwiggyAssignment
//
//  Created by Santosh Kumar Sahoo on 7/31/17.
//  Copyright © 2017 Santosh Kumar Sahoo. All rights reserved.
//

import UIKit

/*
 "group_id":"1",
 "name":"Crust",
 "variations":[
    {
        "name":"Thin",
        "price":0,
        "default":1,
        "id":"1",
        "inStock":1
    }
 ]
 */
class VariantGroup {
    
    let groupId: String?
    let name: String?
    var variations: [Variation]?
    
    var selectedVariation: Variation? {
        if let variations = variations {
            for variation in variations {
                if variation.isSelected {
                    return variation
                }
            }
        }
        return nil
    }
    
    init(dictionary: [String:Any]) {
        groupId = dictionary.getOptionalStringForKey("group_id")
        name = dictionary.getOptionalStringForKey("name")
        if let variationList = dictionary["variations"] as? [[String:Any]] {
            variations = [Variation]()
            for variationDict in variationList {
                variations?.append(Variation(dictionary: variationDict))
            }
        }
    }
}
