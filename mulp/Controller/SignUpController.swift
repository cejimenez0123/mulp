//
//  SignUpController.swift
//  mulp
//
//  Created by Christian Jimenez on 7/7/21.
//

import Foundation
import UIKit


class SignUpController: UIViewController{
    let usernameField = UITextField()
    let passwordField = UITextField()
    let nameField = UITextField()
    let emailField = UITextField()
    let signUpBtn = UIButton()
    let dismissBtn = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(dismissAction))
    init(){

        super.init(nibName: nil, bundle: nil)
        
       
        
    }

    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameField.placeholder = "Username"
        passwordField.placeholder = "Password"
        emailField.placeholder = "Email"
        usernameField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        nameField.translatesAutoresizingMaskIntoConstraints = false
        emailField.translatesAutoresizingMaskIntoConstraints = false
        signUpBtn.translatesAutoresizingMaskIntoConstraints = false
        signUpBtn.backgroundColor = .systemBlue
        signUpBtn.setTitle("Sign Up", for: .normal)
        
        self.view.addSubview(usernameField)
        self.view.addSubview(passwordField)
        self.view.addSubview(emailField)
        self.view.addSubview(signUpBtn)
//        self.view.addSubview(nameField)
        
        NSLayoutConstraint.activate([usernameField.widthAnchor.constraint(equalTo: self.view.widthAnchor),usernameField.heightAnchor.constraint(equalToConstant:30),usernameField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),usernameField.centerYAnchor.constraint(equalTo: emailField.centerYAnchor, constant: -60)])
        NSLayoutConstraint.activate([emailField.widthAnchor.constraint(equalTo: self.view.widthAnchor),emailField.heightAnchor.constraint(equalToConstant: 30),emailField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),emailField.centerYAnchor.constraint(equalTo: self.passwordField.centerYAnchor,constant: -60)])
        NSLayoutConstraint.activate([passwordField.widthAnchor.constraint(equalTo: self.view.widthAnchor),passwordField.heightAnchor.constraint(equalToConstant: 30),passwordField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),passwordField.centerYAnchor.constraint(equalTo: signUpBtn.centerYAnchor, constant: -60)])
        NSLayoutConstraint.activate([signUpBtn.widthAnchor.constraint(equalToConstant: 100),signUpBtn.heightAnchor.constraint(equalToConstant: 40), signUpBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),signUpBtn.centerYAnchor.constraint(equalTo: self.view.centerYAnchor,constant: 70)])
    }
    @objc func dismissAction(_ sender: Any?){
        
        dismiss(animated: true, completion: nil)
    }
}
