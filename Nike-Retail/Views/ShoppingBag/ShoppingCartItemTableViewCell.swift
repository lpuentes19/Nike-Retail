//
//  ShoppingCartItemTableViewCell.swift
//  Nike-Retail
//
//  Created by Luis Puentes on 1/29/18.
//  Copyright © 2018 LuisPuentes. All rights reserved.
//

import UIKit

class ShoppingCartItemTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var removeButton: UIButton!
    
    var product: Product! {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        productImageView.image = nil
        if let imageLink = product.featuredImageLink {
            FIRImage.downloadImage(uri: imageLink, completion: { (image, error) in
                self.productImageView.image = image
            })
        }
        productLabel.text = product.name
        priceLabel.text = "$\(product.price!)"
    }
    @IBAction func removeButtonTapped(_ sender: Any) {
        if let topViewController = UIApplication.topViewController() {
            let alertController = UIAlertController(title: "Warning", message: "Are you sure you wish to remove this item from your shopping cart?", preferredStyle: .alert)
            
            let yesAction = UIAlertAction(title: "Yes", style: .default) { (_) in
                ShoppingCart.remove(product: self.product)
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            alertController.addAction(yesAction)
            alertController.addAction(cancelAction)
            
            topViewController.present(alertController, animated: true, completion: nil)
        }
    }
}

