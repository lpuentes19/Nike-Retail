//
//  BuyButtonTableViewCell.swift
//  Nike-Retail
//
//  Created by Luis Puentes on 1/13/18.
//  Copyright © 2018 LuisPuentes. All rights reserved.
//

import UIKit

protocol BuyButtonCellDelegate: class {
    func addToCart(product: Product)
}

class BuyButtonTableViewCell: UITableViewCell {

    // MARK: - Properties
    weak var delegate: BuyButtonCellDelegate?
    
    var product: Product! {
        didSet {
            buyButton.setTitle("BUY FOR $\(product.price!)", for: [])
        }
    }
    
    // MARK: - Storyboard Outlets
    @IBOutlet weak var buyButton: UIButton!
    
    // MARK: - Storyboard Outlets
    @IBAction func buyButtonTapped() {
        delegate?.addToCart(product: product)
    }
}
