//
//  CheckoutTableViewController.swift
//  Nike-Retail
//
//  Created by Luis Puentes on 1/29/18.
//  Copyright © 2018 LuisPuentes. All rights reserved.
//

import UIKit
import Stripe
import AFNetworking

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
    
    func postToStripe(token: STPToken) {
        
        // URL to your server
        let url = "http://localhost/Nike-Retail/payment.php"
        let params: [String: Any] = [
            "stripeToken": token.tokenId,
            "amount": shoppingCart.total!,
            "currency": "usd",
            "description": self.emailAddressTextField.text!]
        
        let manager = AFHTTPSessionManager().post(url, parameters: params, progress: nil, success: { (operation, responseObject) in
            
            // Check to see if the transaction went through successfully
            if let response = responseObject as? [String: String] {
                print(response["status"]! + "______" + response["message"]!)
                
                let alertController = UIAlertController(title: "Success", message: "You have successfully placed this order!", preferredStyle: .alert)
                
                let okButton = UIAlertAction(title: "OK", style: .default) { (_) in
                    self.dismiss(animated: true, completion: nil)
                }
                
                alertController.addAction(okButton)
                self.present(alertController, animated: true, completion: nil)
            }
            
            // Handle error
        }) { (operation, error) in
            if error != nil {
                self.handleError(error: error)
            }
        }
    }
    
    func handleError(error: Error) {
        let alertController = UIAlertController(title: "Oops! Please try again!", message: error.localizedDescription, preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "OK", style: .default) { (_) in
            self.dismiss(animated: true, completion: nil)
        }
        
        alertController.addAction(okButton)
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Storyboard IBActions
    @IBAction func submitOrderButtonDidTap() {
        // 1 - Initiate a Stripe card
        let stripeCard = STPCardParams()
        // 1.2 - Get the credit card info from the text fields
        guard let expirationDate = expirationDateTextField.text else { return }
        if !expirationDate.isEmpty {
            let expDate = expirationDate.components(separatedBy: "/")
            let expMonth = UInt(expDate[0])
            let expYear = UInt(expDate[1])
            
            // 2 - Send the card information to Stripe to get a token
            stripeCard.number = cardNumberTextField.text
            stripeCard.cvc = securityCodeTextField.text
            stripeCard.expMonth = expMonth!
            stripeCard.expYear = expYear!
            
            // 3 - Validate the card numbers
            STPAPIClient.shared().createToken(withCard: stripeCard) { (token, error) in
                if error != nil {
                    // Handle error
                    self.handleError(error: error!)
                    return
                } else {
                    // We get a token
                    // Post the token to Stripe using our web server
                    self.postToStripe(token: token!)
                }
            }
        }
    }
}
