//
//  SignUpTableViewController.swift
//  Nike-Retail
//
//  Created by Luis Puentes on 2/15/18.
//  Copyright © 2018 LuisPuentes. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpTableViewController: UITableViewController {
    
    // MARK: - Storyboard Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        nameTextField.delegate = self
        usernameTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    // MARK: - Storyboard Actions
    
    @IBAction func signUpButtonTapped() {
        if emailTextField.text != ""
            && (passwordTextField.text?.count)!  > 6
            && (usernameTextField.text?.count)! > 6
            && nameTextField.text != "" {
            
            let username = usernameTextField.text!
            let email = emailTextField.text!
            let password = passwordTextField.text!
            
            Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                if error != nil {
                    // report error
                } else if let user = user {
                    let newUser = User(uid: user.uid, username: username, profileImage: nil)
                    newUser.save(completion: { (error) in
                        if error != nil {
                            // report
                        } else {
                            // Login User
                            Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                                if let error = error {
                                    // report error
                                    print(error)
                                } else {
                                    self.dismiss(animated: true, completion: nil)
                                }
                            })
                        }
                    })
                }
            })
        }
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension SignUpTableViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            nameTextField.becomeFirstResponder()
        } else if textField == nameTextField {
            usernameTextField.becomeFirstResponder()
        } else if textField == usernameTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            passwordTextField.resignFirstResponder()
            signUpButtonTapped()
        }
        return true
    }
}
