//
//  VariationDetailCell.swift
//  SwiggyAssignment
//
//  Created by Santosh Kumar Sahoo on 7/31/17.
//  Copyright © 2017 Santosh Kumar Sahoo. All rights reserved.
//

import UIKit

class VariationDetailCell: UICollectionViewCell {
    
    @IBOutlet weak fileprivate var nameLabel: UILabel!
    @IBOutlet weak fileprivate var priceLabel: UILabel!
    @IBOutlet weak fileprivate var outOfStockLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 4
        layer.borderWidth = 1
    }
    
    func configureCellWithInfo(_ variation: Variation?) {
        nameLabel.text = variation?.name
        if let price = variation?.price {
            priceLabel.text = "Price:₹\(price)"
        } else {
            priceLabel.text = nil
        }
        updateUI(variation)
    }

}

fileprivate extension VariationDetailCell {
    
    func updateUI(_ variation: Variation?) {
        outOfStockLabel.text = variation?.isOutOfStock == true ? "Out of stock" : "In Stock"
        if variation?.isSelected == true {
            setCellAttributeColor(UIColor.selectedColor())
        } else if variation?.willDisable == true {
            setCellAttributeColor(UIColor.lightGray)
        } else{
            setCellAttributeColor(UIColor.black)
        }
    }
    
    func setCellAttributeColor(_ color: UIColor) {
        nameLabel.textColor = color
        priceLabel.textColor = color
        outOfStockLabel.textColor = color
        layer.borderColor = color.cgColor
    }
}
