//
//  LogInController.swift
//  mulp
//
//  Created by Christian Jimenez on 7/6/21.
//

import Foundation
import UIKit
class LogInController: UIViewController{
    let usernameField = UITextField()
    let passwordField = UITextField()
    let emailField = UITextField()
    let logInBtn = UIButton()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameField.placeholder = "Username"
        passwordField.placeholder = "Password"
        emailField.placeholder = "Email"
        logInBtn.setTitle("Log In", for: .normal)
        self.view.addSubview(usernameField)
//        self.view.addSubview(emailField)
        self.view.addSubview(passwordField)
        self.view.addSubview(logInBtn)
        NSLayoutConstraint.activate([usernameField.widthAnchor.constraint(equalTo: self.view.widthAnchor),usernameField.heightAnchor.constraint(equalToConstant: 30),usernameField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),usernameField.centerYAnchor.constraint(equalTo: self.passwordField.centerYAnchor,constant: -60)])
        NSLayoutConstraint.activate([passwordField.widthAnchor.constraint(equalTo: self.view.widthAnchor),passwordField.heightAnchor.constraint(equalToConstant: 30),passwordField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),passwordField.centerYAnchor.constraint(equalTo: logInBtn.centerYAnchor, constant: -60)])
        NSLayoutConstraint.activate([logInBtn.widthAnchor.constraint(equalToConstant: 100),logInBtn.heightAnchor.constraint(equalToConstant: 40), logInBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),logInBtn.centerYAnchor.constraint(equalTo: self.view.centerYAnchor,constant: 70)])
        
    }
    required init(){
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
        
    }
    
}
