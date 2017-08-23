//
//  Variants.swift
//  SwiggyAssignment
//
//  Created by Santosh Kumar Sahoo on 7/31/17.
//  Copyright © 2017 Santosh Kumar Sahoo. All rights reserved.
//

import UIKit

class Variants {
    var variantGroup: [VariantGroup]?
    var excludeList: [[ExcludeDetail]]?
    
    init(dictionary: [String:Any]) {
        if let variantList = dictionary["variant_groups"] as? [[String:Any]] {
            variantGroup = [VariantGroup]()
            for variant in variantList {
                let variantObj = VariantGroup(dictionary: variant)
                variantGroup?.append(variantObj)
            }
        }
        if let excludes = dictionary["exclude_list"] as? [[Any]] {
            excludeList = [[ExcludeDetail]]()
            for excludeList in excludes {
                var excludeArray = [ExcludeDetail]()
                for excludeDict in excludeList {
                    if let excludeDict = excludeDict as? [String:Any] {
                       excludeArray.append(ExcludeDetail(dictionary: excludeDict))
                    }
                }
                self.excludeList?.append(excludeArray)
            }
        }
    }
    
    func getVariationWithGroupId(_ groupId: String?, and variationId: String?) -> Variation? {
        if let variantGroup = variantGroup {
            for variant in variantGroup {
                if variant.groupId == groupId, let variations = variant.variations {
                    for variation in variations {
                        if variation.id == variationId {
                            return variation
                        }
                    }
                }
            }
        }
        return nil
    }
    
    func disableAppropriateVariation(_ selectedVariation: Variation?, groupId: String?) {
        if let excludeList = excludeList {
            for excludeArr in excludeList {
                let isExist = !(excludeArr.filter({$0.groupId == groupId && $0.variationId == selectedVariation?.id }).isEmpty)
                if isExist {
                    for exclude in excludeArr {
                        if exclude.groupId != groupId && exclude.variationId != selectedVariation?.id {
                            let variation = getVariationWithGroupId(exclude.groupId, and: exclude.variationId)
                            variation?.willDisable = (selectedVariation?.isSelected ?? false)
                        }
                    }
                }
            }
        }
    }
}

class ExcludeDetail {
    let groupId: String?
    let variationId: String?
    
    init(dictionary: [String:Any]) {
        groupId = dictionary.getOptionalStringForKey("group_id")
        variationId = dictionary.getOptionalStringForKey("variation_id")
    }
}
