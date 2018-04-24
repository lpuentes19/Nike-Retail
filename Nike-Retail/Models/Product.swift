//
//  Product.swift
//  Nike-Retail
//
//  Created by Luis Puentes on 1/11/18.
//  Copyright © 2018 LuisPuentes. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase

class Product {
    
    var uid: String?
    var name: String?
    var images: [UIImage]?
    var price: Double?
    var description: String?
    var detail: String?
    var relatedProductIDs: [String]?
    
    var imageLinks: [String]?
    var featuredImageLink: String?
    
    init(uid: String?, name: String?, images: [UIImage]?, price: Double?, description: String?, detail: String?, relatedProductIDs: [String]? = ["875942-1001", "880843-0031", "384664-1131", "805144-8521"]) {
        self.uid = uid
        self.name = name
        self.images = images
        self.price = price
        self.description = description
        self.detail = detail
        self.relatedProductIDs = relatedProductIDs
    }
    
//    class func fetchProducts() -> [Product] {
//        var shirts = [Product]()
//
//        // 1
//        var shirt1Images = [UIImage]()
//        for i in 1...2 {
//            shirt1Images.append(UIImage(named: "s\(i)")!)
//        }
//        let shirt1 = Product(uid: "875942-1001", name: "TAKL GREY SHIRT", images: shirt1Images, price: 30, description: "Very soft and flexible material that provides every angular with room to move around and enjoy your time out fishing!", detail: "Very soft and flexible material that provides every angular with room to move around and enjoy your time out fishing!")
//        shirts.append(shirt1)
//
//        // 2
//        var shirt2Images = [UIImage]()
//        for i in 1...2 {
//            shirt2Images.append(UIImage(named: "t\(i)")!)
//        }
//        let shirt2 = Product(uid: "880843-0031", name: "TAKL MAROON SHIRT", images: shirt2Images, price: 25, description: "Very soft and flexible material that provides every angular with room to move around and enjoy your time out fishing!", detail: "Very soft and flexible material that provides every angular with room to move around and enjoy your time out fishing!")
//        shirts.append(shirt2)
//
//
//        // 3
//        var shirt3Images = [UIImage]()
//        for i in 1...2 {
//            shirt3Images.append(UIImage(named: "j\(i)")!)
//        }
//        let shirt3 = Product(uid: "384664-1131", name: "TAKL BLACK SHIRT", images: shirt3Images, price: 20, description: "TVery soft and flexible material that provides every angular with room to move around and enjoy your time out fishing!", detail: "Very soft and flexible material that provides every angular with room to move around and enjoy your time out fishing!")
//        shirts.append(shirt3)
//
//        // 4
//        var shirt4Images = [UIImage]()
//        for i in 1...6 {
//            shirt4Images.append(UIImage(named: "f\(i)")!)
//        }
//        let shirt4 = Product(uid: "805144-8521", name: "TECH FLEECE WINDRUNNER", images: shirt4Images, price: 130, description: "The Nike Sportswear Tech Fleece Windrunner Men's Hoodie is redesigned for cooler weather with smooth, engineered fleece that offers lightweight warmth. Bonded seams lend a modern update to the classic chevron design.", detail: "The Nike Sportswear Tech Fleece Windrunner Men's Hoodie is redesigned for cooler weather with smooth, engineered fleece that offers lightweight warmth. Bonded seams lend a modern update to the classic chevron design.")
//        shirts.append(shirt4)
//
//        return shirts
//    }
}

extension Product {
    var ref: DatabaseReference! {
        get {
            if let uid = self.uid {
                return DatabaseRef.products(uid: uid).reference()
            } else {
                return nil
            }
        }
    }
    
    convenience init(dictionary: [String: Any]) {
        let uid = dictionary["uid"] as? String
        let name = dictionary["name"] as? String
        let price = dictionary["price"] as? Double
        let description = dictionary["description"] as? String
        let detail = dictionary["detail"] as? String
        let relatedProductUDs = dictionary["relatedProductIDs"] as? [String]
        
        var imgLinks = [String]()
        if let imgLinkDict = dictionary["images"] as? [String: Any] {
            for (_, imgLink) in imgLinkDict {
                imgLinks.append(imgLink as! String)
            }
        }
        
        self.init(uid: uid, name: name, images: nil, price: price, description: description, detail: detail, relatedProductIDs: relatedProductUDs)
        self.imageLinks = imgLinks
        self.featuredImageLink = dictionary["featuredImageLink"] as? String
    }
    
    class func fetchProducts(completion: @escaping ([Product])-> Void) {
        Database.database().reference().child("products").observeSingleEvent(of: .value, with: { snapshot in
            var products = [Product]()
            for childSnapshot in snapshot.children {
                if let childSnapshot = childSnapshot as? DataSnapshot,
                    let dictionary = childSnapshot.value as? [String: Any] {
                    
                    let product = Product(dictionary: dictionary)
                    products.append(product)
                }
            }
            completion(products)
        })
    }
    
    func save(completion: @escaping (Error?) -> Void) {
        if let images = images {
            for image in images {
                let firImage = FIRImage(image: image)
                let randomID = ref.childByAutoId().key
                firImage.save(randomID, completion: { (error) in
                    self.ref.child("images").childByAutoId().setValue(firImage.downloadURI!)
                    completion(error)
                })
            }
        }
        self.ref.setValue(toDictionary())
    }
    
    func toDictionary() -> [String: Any] {
        guard let uid = self.uid, let name = self.name, let price = price, let description = description, let detail = detail, let relatedProductIDs = relatedProductIDs else { return [:] }
        
        return [
            "uid": uid,
            "name": name,
            "price": price,
            "description": description,
            "detail": detail,
            "relatedProductIDs": relatedProductIDs,
            "featuredImageLink" : imageLinks?.first
        ]
    }
}
