//
//  ShoppingBagTableViewController.swift
//  Nike-Retail
//
//  Created by Luis Puentes on 1/29/18.
//  Copyright © 2018 LuisPuentes. All rights reserved.
//

import UIKit

class ShoppingBagTableViewController: UITableViewController {

    // ReuseIdentifiers
    struct ReuseIdentifiers {
        static let numberOfItemsCell = "numberOfItemsCell"
        static let itemCell = "itemCell"
        static let cartSubtotalCell = "cartSubtotalCell"
        static let totalCell = "totalCell"
        static let checkoutButtonCell = "checkoutButtonCell"
        static let showCheckout = "toCheckoutVC"
    }
    
    // MARK: - Properties
    var products: [Product]?
    var shoppingCart = ShoppingCart()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchProducts()
    }
    
    func fetchProducts() {
        self.products?.removeAll()
        shoppingCart.fetch { [weak self] () in
            self?.products = self?.shoppingCart.products
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let products = products {
            return products.count + 4
        } else {
            return 1
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let products = products else {
            let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifiers.numberOfItemsCell, for: indexPath) as! NumberOfItemsTableViewCell
            
            cell.numberOfItemsLabel.text = "0 ITEMS"
            
            return cell
        }
        
        if indexPath.row == 0 {
            // Number of Items Cell
            let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifiers.numberOfItemsCell, for: indexPath) as! NumberOfItemsTableViewCell
            
            cell.numberOfItemsLabel.text = (products.count == 1) ? "\(products.count) ITEM" : "\(products.count) ITEMS"
            
            return cell
            
        } else if indexPath.row == products.count + 1 {
            // Cart Detail Cell
            let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifiers.cartSubtotalCell, for: indexPath) as! CartSubtotalTableViewCell
            
            cell.shoppingCart = shoppingCart
            
            return cell
            
        } else if indexPath.row == products.count + 2 {
            // Cart Total Cell
            let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifiers.totalCell, for: indexPath) as! CartTotalTableViewCell
            
            cell.shoppingCart = shoppingCart
            
            return cell
            
        } else if indexPath.row == products.count + 3 {
            // Checkout Button Cell
            let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifiers.checkoutButtonCell, for: indexPath)
            
            return cell
            
        } else {
            // Shopping Bag Item Cell
            let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifiers.itemCell, for: indexPath) as! ShoppingCartItemTableViewCell
            cell.product = products[indexPath.row - 1]
            
            Product.fetchProducts { (product) in
                cell.product = product[indexPath.row]
            }
            
            return cell
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == ReuseIdentifiers.showCheckout {
            let checkoutTVC = segue.destination as! CheckoutTableViewController
            checkoutTVC.shoppingCart = shoppingCart
        }
    }
}
