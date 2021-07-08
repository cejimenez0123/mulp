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
    let nameField = UITextField()
    let emailField = UITextField()
    let logInBtn = UIButton()
  
    override func viewDidLoad() {
        usernameField.placeholder = "Username"
        passwordField.placeholder = "Password"
        emailField.placeholder = "E-mail"
        nameField.placeholder = "Name"
        logInBtn.setTitle("Log In", for: .normal)
        self.view.addSubview(usernameField)
        self.view.addSubview(usernameField)
        self.view.addSubview(usernameField)
        self.view.addSubview(usernameField)
        
    }
    required init(){
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
        
    }
    
}
