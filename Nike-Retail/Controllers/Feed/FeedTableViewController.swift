//
//  FeedTableViewController.swift
//  Nike-Retail
//
//  Created by Luis Puentes on 1/13/18.
//  Copyright © 2018 LuisPuentes. All rights reserved.
//

import UIKit
import FirebaseAuth

class FeedTableViewController: UITableViewController {
    
    // MARK: - Properties
    var products: [Product]?
    var selectedProduct: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchProducts()
        adjustTableViewRowHeight()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if Auth.auth().currentUser == nil {
            self.performSegue(withIdentifier: "showWelcome", sender: nil)
        } else {
            // Start doing something with the user here
        }
    }
    
    // Dyanmic TableView Row Height
    func adjustTableViewRowHeight() {
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    // Calling the Fetch Products from our Products Model class
    func fetchProducts() {
        products = Product.fetchProducts()
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let products = products {
            return products.count
        } else {
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedProductCell", for: indexPath) as! FeedProductTableViewCell

        if let products = products {
            let product = products[indexPath.row]
            cell.product = product
        }
        return cell
    }
    
    // MARK: - UITableview Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedProduct = products?[indexPath.row]
        performSegue(withIdentifier: "showProductDetail", sender: nil)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showProductDetail" {
            if let productDetailVC = segue.destination as? ProductDetailTableViewController {
                productDetailVC.product = selectedProduct
            }
        }
    }
}
















