//
//  VariantGroupDetailCell.swift
//  SwiggyAssignment
//
//  Created by Santosh Kumar Sahoo on 7/31/17.
//  Copyright © 2017 Santosh Kumar Sahoo. All rights reserved.
//

import UIKit

protocol VariantGroupDetailCellDelegate : NSObjectProtocol {
    func cell(_ cell: VariantGroupDetailCell?, didSelectVariantion variation: Variation?, at indexPath: IndexPath?)
}

class VariantGroupDetailCell: UITableViewCell {

    @IBOutlet weak fileprivate var collectionView: UICollectionView!
    @IBOutlet weak fileprivate var variantGroupTitleLabel: UILabel!
    
    fileprivate var variantGroup: VariantGroup?
    weak fileprivate var delegate: VariantGroupDetailCellDelegate?
    fileprivate var indexPath: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func configureCellWithInfo(_ variantGroup: VariantGroup?,at indexPath: IndexPath, delegate: VariantGroupDetailCellDelegate? ) {
        self.delegate = delegate
        self.indexPath = indexPath
        if let variantGroup = variantGroup {
            self.variantGroup = variantGroup
            variantGroupTitleLabel.text = variantGroup.name
            collectionView.reloadData()
        }
    }
    
}

//MARK: - CollectionViewDatasource methods
extension VariantGroupDetailCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return variantGroup?.variations?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VariationDetailCell", for: indexPath) as! VariationDetailCell
        cell.configureCellWithInfo(variantGroup?.variations?[indexPath.row])
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout methods
extension VariantGroupDetailCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.size.width - 30)/3, height: 75)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if variantGroup?.variations?[indexPath.row].willDisable == false {
            delegate?.cell(self, didSelectVariantion: variantGroup?.variations?[indexPath.row], at: self.indexPath)
        }
    }
}
