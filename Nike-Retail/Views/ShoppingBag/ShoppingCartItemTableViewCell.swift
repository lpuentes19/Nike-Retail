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
}
