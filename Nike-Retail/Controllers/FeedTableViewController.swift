//
//  FeedTableViewController.swift
//  Nike-Retail
//
//  Created by Luis Puentes on 1/13/18.
//  Copyright © 2018 LuisPuentes. All rights reserved.
//

import UIKit

class FeedTableViewController: UITableViewController {
    
    // MARK: - Properties
    var products: [Product]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "FEED"
        fetchProducts()
    }

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
}
















