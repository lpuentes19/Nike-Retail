//
//  ShoppingCart.swift
//  Nike-Retail
//
//  Created by Luis Puentes on 2/20/18.
//  Copyright © 2018 LuisPuentes. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

private let caTaxPercentage = 0.00
private let freeShippingLimit = 50.00
private let defaultShippingFee = 5.99

class ShoppingCart {
    
    var products: [Product]?
    var shipping: Double?
    var subtotal: Double?
    var tax: Double?
    var total: Double?
    
    class func add(product: Product) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let ref = DatabaseRef.users(uid: userID).reference().child("shoppingCart")
        
        ref.runTransactionBlock({ (currentData) -> TransactionResult in
            
            // the last-known state of the current shopping cart, nil if there's none shopping cart
            
            var cart = currentData.value as? [String: Any] ?? [:]
            var productDictionary = cart["products"] as? [String: Any] ?? [:]
            
            // add the new product to the dictionary
            productDictionary[product.uid!] = product.toDictionary()
            
            // re-calculate the detail of the shoppping cart - total, subtotal, shipping, tax
            var shipping: Double = 0
            var subtotal: Double = 0
            var tax: Double = 0
            var total: Double = 0
            
            for (_, productDict) in productDictionary {
                if let productDict = productDict as? [String: Any] {
                    let price = productDict["price"] as! Double
                    subtotal += price
                }
            }
            
            if subtotal >= freeShippingLimit || subtotal == 0 {
                shipping = 0
            } else {
                shipping = defaultShippingFee
            }
            
            tax = (subtotal + shipping) * caTaxPercentage
            total = subtotal + shipping + tax
            
            // update back the values to cart
            cart["subtotal"] = subtotal
            cart["shipping"] = subtotal
            cart["tax"] = subtotal
            cart["total"] = subtotal
            cart["products"] = subtotal
            
            // return back the value of the currentData as the new updated cart - so we can upload this to our firebase
            currentData.value = cart
            
            return TransactionResult.success(withValue: currentData)
            
        }) { (error, committed, snapshot) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func fetch(_ completion: @escaping() -> Void)
    {
        let userUID = Auth.auth().currentUser!.uid
        let ref = DatabaseRef.users(uid: userUID).reference().child("shoppingCart")
        ref.runTransactionBlock({ (currentData: MutableData) -> TransactionResult in
            
            if let cart = currentData.value as? [String : Any],
                let shipping = cart["shipping"] as? Double,
                let subtotal = cart["subtotal"] as? Double,
                let tax = cart["tax"] as? Double,
                let total = cart["total"] as? Double,
                let productsDictionary = cart["products"] as? [String : Any] {
                self.shipping = shipping
                self.subtotal = subtotal
                self.total = total
                self.tax = tax
                
                self.products = [Product]()
                for (_, productDict) in productsDictionary {
                    if let productDict = productDict as? [String : Any] {
                        let product = Product(dictionary: productDict)
                        self.products?.append(product)
                    }
                }
                
                completion()
            }
            
            return TransactionResult.success(withValue: currentData)
            
        }) { (error, committed, snapshot) in
            if let error = error {
                // TODO: report error here
                print(error.localizedDescription)
            }
        }
    }
}
