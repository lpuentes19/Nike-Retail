//
//  SuggestionCollectionViewCell.swift
//  Nike-Retail
//
//  Created by Luis Puentes on 1/27/18.
//  Copyright © 2018 LuisPuentes. All rights reserved.
//

import UIKit

class SuggestionCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    @IBOutlet weak var imageView: UIImageView!
    
    var product: Product? {
        didSet {
            updateUI()
        }
    }
    
    var image: UIImage! {
        didSet {
            imageView.image = image
            setNeedsLayout()
        }
    }
    
    func updateUI() {
        
        if let product = product {
            
            // Download the first image for each product for Suggested Items
            if let imageLinks = product.imageLinks,
                let imageLink = imageLinks.first {
                
                FIRImage.downloadImage(uri: imageLink, completion: { (image, error) in
                    if error == nil {
                        self.imageView.image = image
                    }
                })
            }
        }
    }
}
