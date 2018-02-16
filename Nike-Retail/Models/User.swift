//
//  User.swift
//  Nike-Retail
//
//  Created by Luis Puentes on 2/15/18.
//  Copyright © 2018 LuisPuentes. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase

class User {
    
    let uid: String
    var username: String
    var profileImage: UIImage?
    
    // MARK: - Initializers
    
    init(uid: String = "", username: String, profileImage: UIImage?) {
        
        self.uid = uid
        self.username = username
        self.profileImage = profileImage
    }
    
    init(dictionary: [String : Any]) {
        
        uid = dictionary["uid"] as! String
        username = dictionary["username"] as! String
    }
    
    func save(completion: @escaping (Error?) -> Void) {
        
        // 1
        let ref = DatabaseRef.users(uid: uid).reference()
        ref.setValue(toDictionary())
        
        // 4 - save the profile image
        if let profileImage = self.profileImage {
            let firImage = FIRImage(image: profileImage)
            firImage.saveProfileImage(self.uid, { (error) in
                completion(error)
            })
        }
    }
    
    func toDictionary() -> [String : Any] {
        return [
            "uid" : uid,
            "username" : username]
    }
}

extension User: Equatable { }

func ==(lhs: User, rhs: User) -> Bool {
    return lhs.uid == rhs.uid
}
