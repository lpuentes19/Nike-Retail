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
        static let cartDetailCell = "cartDetailCell"
        static let totalCell = "totalCell"
        static let checkoutButtonCell = "checkoutButtonCell"
    }
    
    // MARK: - Properties
    var products: [Product]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        
        fetchProducts()
    }
    
    func fetchProducts() {
        products = Product.fetchProducts()
        tableView.reloadData()
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
            
            cell.numberOfItemsLabel.text = "0 Item"
            
            return cell
        }
        
        if indexPath.row == 0 {
            // Number of Items Cell
            let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifiers.numberOfItemsCell, for: indexPath) as! NumberOfItemsTableViewCell
            
            cell.numberOfItemsLabel.text = (products.count == 1) ? "\(products.count) Item" : "\(products.count) Items"
            
            return cell
            
        } else if indexPath.row == products.count + 1 {
            // Cart Detail Cell
            let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifiers.cartDetailCell, for: indexPath)
            
            return cell
            
        } else if indexPath.row == products.count + 2 {
            // Cart Total Cell
            let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifiers.totalCell, for: indexPath)
            
            return cell
            
        } else if indexPath.row == products.count + 3 {
            // Checkout Button Cell
            let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifiers.checkoutButtonCell, for: indexPath)
            
            return cell
            
        } else {
            // Shopping Bag Item Cell
            let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifiers.itemCell, for: indexPath) as! ShoppingCartItemTableViewCell
            cell.product = products[indexPath.row - 1]
            
            return cell
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
