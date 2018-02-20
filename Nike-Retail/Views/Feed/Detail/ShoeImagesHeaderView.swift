//
//  ShoeImagesHeaderView.swift
//  Nike-Retail
//
//  Created by Luis Puentes on 1/20/18.
//  Copyright © 2018 LuisPuentes. All rights reserved.
//

import UIKit

class ShoeImagesHeaderView: UIView, ProductImagesPageViewControllerDelegate {
    // MARK: - Properties
    @IBOutlet weak var pageControl: UIPageControl!
    
    // MARK: - Custom Delegate Methods
    func setupPageController(numberOfPages: Int) {
        pageControl.numberOfPages = numberOfPages
    }
    
    func turnPageController(to index: Int) {
        pageControl.currentPage = index
    }
}
