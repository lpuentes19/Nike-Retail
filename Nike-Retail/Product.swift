//
//  Product.swift
//  Nike-Retail
//
//  Created by Luis Puentes on 1/11/18.
//  Copyright © 2018 LuisPuentes. All rights reserved.
//

import Foundation
import UIKit

class Product {
    
    var uid: String?
    var name: String?
    var images: [UIImage]?
    var price: Double?
    var description: String?
    var detail: String?
    var relatedProductIDs: [String]?
    
    init(uid: String?, name: String?, images: [UIImage]?, price: Double?, description: String?, detail: String?, relatedProductIDs: [String]? = ["875942-100", "880843-003", "384664-113", "805144-852"]) {
        self.uid = uid
        self.name = name
        self.images = images
        self.price = price
        self.description = description
        self.detail = detail
        self.relatedProductIDs = relatedProductIDs
    }
}
