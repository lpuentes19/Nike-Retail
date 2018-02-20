//
//  ShoeImageViewController.swift
//  Nike-Retail
//
//  Created by Luis Puentes on 1/17/18.
//  Copyright © 2018 LuisPuentes. All rights reserved.
//

import UIKit

class ProductImageViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var productImage: UIImageView!
    
    var imageLink: String? {
        didSet {
            if let imageLink = imageLink {
                FIRImage.downloadImage(uri: imageLink, completion: { (image, error) in
                    if error == nil && image != nil {
                        self.productImage.image = image
                    }
                })
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
