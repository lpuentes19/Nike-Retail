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
    
    var image: UIImage! {
        didSet {
            imageView.image = image
            setNeedsLayout()
        }
    }
}
