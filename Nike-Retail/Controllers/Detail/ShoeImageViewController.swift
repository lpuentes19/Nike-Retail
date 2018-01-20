//
//  ShoeImageViewController.swift
//  Nike-Retail
//
//  Created by Luis Puentes on 1/17/18.
//  Copyright © 2018 LuisPuentes. All rights reserved.
//

import UIKit

class ShoeImageViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var shoeImage: UIImageView!
    
    var image: UIImage? {
        didSet {
            self.shoeImage?.image = image
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shoeImage.image = image
    }
    
}
