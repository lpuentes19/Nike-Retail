//
//  CheckoutTableViewController.swift
//  Nike-Retail
//
//  Created by Luis Puentes on 1/29/18.
//  Copyright © 2018 LuisPuentes. All rights reserved.
//

import UIKit

class CheckoutTableViewController: UITableViewController {

    // ReuseIdentifiers
    struct ReuseIdentifiers {
        static let billingInfoCell = "billingInfoCell"
        static let creditCardInfoCell = "creditCardInfoCell"
        static let totalDetailCell = "totalDetailCell"
        static let totalCell = "totalCell"
        static let submitButtonCell = "submitButtonCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifiers.billingInfoCell, for: indexPath)
            
            return cell
            
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifiers.creditCardInfoCell, for: indexPath)
            
            return cell
            
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifiers.totalDetailCell, for: indexPath)
            
            return cell
            
        } else if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifiers.totalCell, for: indexPath)
            
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifiers.submitButtonCell, for: indexPath)
            
            return cell
        }
    }
}
