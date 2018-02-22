//
//  CartTotalTableViewCell.swift
//  Nike-Retail
//
//  Created by Luis Puentes on 2/21/18.
//  Copyright © 2018 LuisPuentes. All rights reserved.
//

import UIKit

class CartTotalTableViewCell: UITableViewCell {

    @IBOutlet weak var totalAmountLabel: UILabel!
    
    var shoppingCart: ShoppingCart! {
        didSet {
            totalAmountLabel.text = "$\(shoppingCart.total!)"
        }
    }
}
