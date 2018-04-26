//
//  FirebaseImage.swift
//  Nike-Retail
//
//  Created by Luis Puentes on 2/15/18.
//  Copyright © 2018 LuisPuentes. All rights reserved.
//

import Foundation
import UIKit
import FirebaseStorage

class FIRImage {
    
    var image: UIImage
    var downloadURI: String?
    var ref: StorageReference!
    
    init(image: UIImage) {
        self.image = image
    }
}

extension FIRImage {
    
    func saveProfileImage(_ userUID: String, _ completion: @escaping (Error?) -> Void) {
        
        let resizedImage = image.resized()
        let imageData = UIImageJPEGRepresentation(resizedImage, 0.9)
        
        ref = StorageRef.profileImages.reference().child(userUID)
        downloadURI = ref.description
        
        ref.putData(imageData!, metadata: nil) { (metaData, error) in
            completion(error)
        }
    }
    
    func save(_ uid: String, completion: @escaping (Error?) -> Void) {
        
        let resizedImage = self.image.resized()
        let imageData = UIImageJPEGRepresentation(resizedImage, 0.9)
        
        ref = StorageRef.images.reference().child(uid)
        downloadURI = ref.description
        
        self.ref.putData(imageData!, metadata: nil) { (metaData, error) in
            completion(error)
        }
    }
}


extension FIRImage {
    
    class func downloadProfileImage(_ uid: String, completion: @escaping (UIImage?, Error?) -> Void) {
        
        StorageRef.profileImages.reference().child(uid).getData(maxSize: 1 * 1024 * 1024) { (imageData, error) in
            if error == nil && imageData != nil {
                let image = UIImage(data: imageData!)
                completion(image, error)
            } else {
                completion(nil, error)
            }
        }
    }
    
    
    class func downloadImage(uri: String, completion: @escaping (UIImage?, Error?) -> Void) {
        
        Storage.storage().reference(forURL: uri).getData(maxSize: 1 * 1024 * 1024) { (imageData, error) in
            if error == nil && imageData != nil {
                let image = UIImage(data: imageData!)
                completion(image, error)
            } else {
                completion(nil, error)
            }
        }
    }
    
    class func downloadImage(uid: String, completion: @escaping (UIImage?, Error?) -> Void) {
        
        StorageRef.images.reference().child(uid).getData(maxSize: 1 * 1024 * 1024) { (imageData, error) in
            if error == nil && imageData != nil {
                let image = UIImage(data: imageData!)
                completion(image, error)
            } else {
                completion(nil, error)
            }
        }
    }
}


private extension UIImage {
    
    func resized() -> UIImage {
        let height: CGFloat = 800.0
        let ratio = self.size.width / self.size.height
        let width = height * ratio
        
        let newSize = CGSize(width: width, height: height)
        let newRectangle = CGRect(x: 0, y: 0, width: width, height: height)
        
        UIGraphicsBeginImageContext(newSize)
        self.draw(in: newRectangle)
        
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return resizedImage!
    }
}
