//
//  CheckoutTableViewController.swift
//  Nike-Retail
//
//  Created by Luis Puentes on 1/29/18.
//  Copyright © 2018 LuisPuentes. All rights reserved.
//

import UIKit

class CheckoutTableViewController: UITableViewController {

    // MARK: - Properties
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var cardNumberTextField: UITextField!
    @IBOutlet weak var expirationDateTextField: UITextField!
    @IBOutlet weak var securityCodeTextField: UITextField!
    
    @IBOutlet weak var subtotalLabel: UILabel!
    @IBOutlet weak var shippingCostLabel: UILabel!
    @IBOutlet weak var taxLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    
    var shoppingCart: ShoppingCart!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    
    func updateUI() {
        if shoppingCart != nil {
            if let subtotal = shoppingCart.subtotal, let shipping = shoppingCart.shipping, let tax = shoppingCart.tax, let total = shoppingCart.total {
                subtotalLabel.text = "$\(subtotal)"
                
                if shipping == 0 {
                    shippingCostLabel.text = "FREE"
                } else {
                    shippingCostLabel.text = "$\(shipping)"
                }
                
                taxLabel.text = "$\(tax)"
                totalLabel.text = "$\(total)"
            }
        }
    }
}
