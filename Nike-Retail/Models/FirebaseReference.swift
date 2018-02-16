//
//  FirebaseReference.swift
//  Nike-Retail
//
//  Created by Luis Puentes on 2/15/18.
//  Copyright © 2018 LuisPuentes. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage

enum DatabaseRef {
    
    case root
    case users(uid: String)
    case products(uid: String)
    
    // MARK: - Public
    
    func reference() -> DatabaseReference {
        switch self {
        case .root:
            return rootRef
        default:
            return rootRef.child(path)
        }
    }
    
    private var rootRef: DatabaseReference {
        return Database.database().reference()
    }
    
    private var path: String {
        switch self {
        case .root:
            return ""
        case .users(let uid):
            return "users/\(uid)"
        case .products(let uid):
            return "products/\(uid)"
        }
    }
}

enum StorageRef {
    
    case root
    case profileImages  // for user's profile image
    case images // general images in app
    
    func reference() -> StorageReference {
        return baseRef.child(path)
    }
    
    private var baseRef: StorageReference {
        return Storage.storage().reference()
    }
    
    private var path: String {
        switch self {
        case .root:
            return ""
        case .profileImages:
            return "profileImages"
        case .images:
            return "images"
        }
    }
}
