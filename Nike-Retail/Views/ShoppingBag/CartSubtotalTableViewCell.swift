//
//  CartSubtotalTableViewCell.swift
//  Nike-Retail
//
//  Created by Luis Puentes on 2/21/18.
//  Copyright © 2018 LuisPuentes. All rights reserved.
//

import UIKit

class CartSubtotalTableViewCell: UITableViewCell {

    // MARK: - Properties
    
    @IBOutlet weak var subtotalLabel: UILabel!
    @IBOutlet weak var shippingCostLabel: UILabel!
    @IBOutlet weak var taxAmountLabel: UILabel!
    
    var shoppingCart: ShoppingCart! {
        didSet {
            subtotalLabel.text = "$\(shoppingCart.subtotal!)"
            shippingCostLabel.text = shoppingCart.shipping! == 0 ? "FREE" : "$\(shoppingCart.shipping!)"
            taxAmountLabel.text = "$\(shoppingCart.tax!)"
        }
    }
}
