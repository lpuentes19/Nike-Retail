//
//  WelcomeViewController.swift
//  Nike-Retail
//
//  Created by Luis Puentes on 2/15/18.
//  Copyright © 2018 LuisPuentes. All rights reserved.
//

import UIKit
import FirebaseAuth

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                // Just logged in successfully
                self.dismiss(animated: true, completion: nil)
            } else {
                
            }
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
