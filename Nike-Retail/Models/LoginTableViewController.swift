//
//  LoginTableViewController.swift
//  Nike-Retail
//
//  Created by Luis Puentes on 2/15/18.
//  Copyright © 2018 LuisPuentes. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginTableViewController: UITableViewController {
    
    // MARK: - Storyboard Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.becomeFirstResponder()
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    // MARK: - Functions
    func alert(title: String, message: String, buttonTitle: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonTitle, style: .default, handler: nil)
        alertVC.addAction(action)
        present(alertVC, animated: true, completion: nil)
    }
    
    // MARK: - Storyboard Actions
    @IBAction func loginButtonTapped() {
        if emailTextField.text != "" && (passwordTextField.text?.characters.count)! > 6 {
            let email = emailTextField.text!
            let password = passwordTextField.text!
            
            Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                if let error = error {
                    self.alert(title: "Oops!", message: error.localizedDescription, buttonTitle: "OK")
                } else {
                    self.dismiss(animated: true, completion: nil)
                }
            })
        }
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension LoginTableViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            passwordTextField.resignFirstResponder()
            loginButtonTapped()
        }
        return true
    }
}
