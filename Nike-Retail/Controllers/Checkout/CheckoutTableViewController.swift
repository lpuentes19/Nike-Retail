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
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)


        return cell
    }
}
