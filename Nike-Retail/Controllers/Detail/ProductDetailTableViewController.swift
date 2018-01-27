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
        static let showImagesPageVC = "ShowImagesPageViewController"
        static let productDetailCell = "productDetailCell"
        static let buyButtonCell = "buyButtonCell"
        static let showProductDetailCell = "showProductDetailCell"
        static let suggestionCell = "suggestionCell"
    }
    
    // MARK: - Properties
    @IBOutlet weak var shoeImagesHeaderView: ShoeImagesHeaderView!
    
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

    // MARK: - UITableView DataSource
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
            
            let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifiers.buyButtonCell, for: indexPath) as! BuyButtonTableViewCell
            cell.product = product
            
            return cell
            
        } else if indexPath.row == 2 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifiers.showProductDetailCell, for: indexPath)
            
            return cell
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifiers.suggestionCell, for: indexPath) as! SuggestionTableViewCell
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 3 {
            return tableView.frame.width + 68
        } else {
            return UITableViewAutomaticDimension
        }
    }
    
    // MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == 3 {
            if let cell = cell as? SuggestionTableViewCell {
                cell.collectionView.dataSource = self
                cell.collectionView.delegate = self
                cell.collectionView.reloadData()
                cell.collectionView.isScrollEnabled = false
            }
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == ReuseIdentifiers.showImagesPageVC {
            if let imagesPageVC = segue.destination as? ShoeImagesPageViewController {
                imagesPageVC.images = product.images
                imagesPageVC.pageViewControllerDelegate = shoeImagesHeaderView
            }
        }
    }
}

extension ProductDetailTableViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // MARK: - UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "suggestionCollectionViewCell", for: indexPath) as! SuggestionCollectionViewCell
        
        let products = Product.fetchProducts()
        cell.image = products[indexPath.item].images?.first
        
        return cell
    }
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumLineSpacing = 5.0
            layout.minimumLineSpacing = 2.5
            let itemWidth = (collectionView.frame.width - 5.0) / 2.0
            
            return CGSize(width: itemWidth, height: itemWidth)
        }
        return CGSize.zero
    }
}






