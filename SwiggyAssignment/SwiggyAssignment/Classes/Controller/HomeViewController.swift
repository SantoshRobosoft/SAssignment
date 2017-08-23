
//
//  HomeViewController.swift
//  SwiggyAssignment
//
//  Created by Santosh Kumar Sahoo on 7/31/17.
//  Copyright © 2017 Santosh Kumar Sahoo. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    //MARK: - IBOutlet
    @IBOutlet weak fileprivate var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak fileprivate var tableView: UITableView!
    
    //MARK: - Properties
    fileprivate var variants: Variants?
    
    //MARK: - ViewLifeCycle method
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        fetchVariantsInfo()
    }
    
}

//MARK: - UITableViewDataSource methods
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return variants?.variantGroup?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VariantGroupDetailCell", for: indexPath) as! VariantGroupDetailCell
        cell.configureCellWithInfo(variants?.variantGroup?[indexPath.row], at: indexPath,delegate: self)
        return cell
    }
    
}

//MARK: - Helper methods
fileprivate extension HomeViewController {
    
    func fetchVariantsInfo() {
        activityIndicator.startAnimating()
        NetworkManager.getVarientsDetailWithUrl("https://api.myjson.com/bins/3b0u2") {[weak self] (variants: Variants?, error: NSError?) in
            self?.activityIndicator.stopAnimating()
            if let error = error {
                let alert = UIAlertController(title: error.domain, message: error.localizedDescription , preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
                self?.present(alert, animated: true, completion: nil)
            } else {
                self?.variants = variants
                self?.tableView.reloadData()
            }
        }
    }
}

//MARK: - VariantGroupDetailCellDelegate methods
extension HomeViewController: VariantGroupDetailCellDelegate {
    
    func cell(_ cell: VariantGroupDetailCell?, didSelectVariantion variation: Variation?, at indexPath: IndexPath?) {
        if let variation = variation, let indexPath = indexPath {
            let variantGroup = variants?.variantGroup?[indexPath.row]
            //deselect previously selected variation for the selected group
            if let selectedVariationOldValue = variantGroup?.selectedVariation , variation.id != selectedVariationOldValue.id {
                selectedVariationOldValue.isSelected = false
                variants?.disableAppropriateVariation(selectedVariationOldValue, groupId: variantGroup?.groupId)
            }
            variation.isSelected = !variation.isSelected
            //disable appropriate variation based on exclude list
            variants?.disableAppropriateVariation(variation, groupId: variantGroup?.groupId)
            if !variation.isSelected, let variantGroup = variants?.variantGroup {
                for variant in variantGroup {
                    if let selectedVariation = variant.selectedVariation {
                        variants?.disableAppropriateVariation(selectedVariation, groupId: variant.groupId)
                    }
                }
            }
            tableView.reloadData()
        }
    }
}
