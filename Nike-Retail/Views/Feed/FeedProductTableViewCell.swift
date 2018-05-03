//
//  FeedProductTableViewCell.swift
//  Nike-Retail
//
//  Created by Luis Puentes on 1/13/18.
//  Copyright © 2018 LuisPuentes. All rights reserved.
//

import UIKit

class FeedProductTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    
    var product: Product? {
        didSet {
            updateUI()
        }
    }

    func updateUI() {
        if let product = product {
            
            // Download the product image
            if let imageLinks = product.imageLinks,
                let imageLink = imageLinks.first {
                
                FIRImage.downloadImage(uri: imageLink, completion: { (image, error) in
                    if error == nil {
                        self.productImageView.image = image
                    }
                })
            }
            
            productNameLabel.text = product.name
            productPriceLabel.text = "$\(product.price!)"
        }
    }
}
