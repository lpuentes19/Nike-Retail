//
//  ProductDetailTableViewController.swift
//  Nike-Retail
//
//  Created by Luis Puentes on 1/13/18.
//  Copyright © 2018 LuisPuentes. All rights reserved.
//

import UIKit

class ProductDetailTableViewController: UITableViewController {
    
    // ReuseIdentifiers
    struct ReuseIdentifiers {
        static let productDetailCell = "productDetailCell"
        static let buyButtonCell = "buyButtonCell"
        static let showProductDetailCell = "showProductDetailCell"
    }
    
    // MARK: - Properties
    var product: Product!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = product.name
        adjustTableViewRowHeight()
    }
    
    // Dyanmic TableView Row Height
    func adjustTableViewRowHeight() {
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifiers.productDetailCell, for: indexPath) as! ProductDetailTableViewCell
            cell.product = product
            
            return cell
            
        } else if indexPath.row == 1 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifiers.buyButtonCell, for: indexPath) as! ProductDetailTableViewCell
            cell.product = product
            
            return cell
            
        } else if indexPath.row == 2 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifiers.showProductDetailCell, for: indexPath) as! ProductDetailTableViewCell
            cell.product = product
            
            return cell
            
        } else {
            return UITableViewCell()
        }
    }
}
