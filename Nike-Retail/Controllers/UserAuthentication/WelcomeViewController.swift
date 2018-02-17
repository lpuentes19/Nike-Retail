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

    // MARK: - Storyboard Outlets
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupButtons()
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
    
    func setupButtons() {
        createAccountButton.layer.cornerRadius = 5
        createAccountButton.layer.masksToBounds = true
        
        loginButton.layer.cornerRadius = 5
        loginButton.layer.masksToBounds = true
    }
}
