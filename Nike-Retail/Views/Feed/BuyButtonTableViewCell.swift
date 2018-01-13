//
//  BuyButtonTableViewCell.swift
//  Nike-Retail
//
//  Created by Luis Puentes on 1/13/18.
//  Copyright © 2018 LuisPuentes. All rights reserved.
//

import UIKit

class BuyButtonTableViewCell: UITableViewCell {

    // MARK: - Properties
    @IBOutlet weak var buyButton: UIButton!
    
    var product: Product! {
        didSet {
            buyButton.setTitle("BUY FOR $\(product.price!)", for: [])
        }
    }
}
