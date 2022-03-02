//
//  LogInController.swift
//  mulp
//
//  Created by Christian Jimenez on 7/6/21.
//

import Foundation
import UIKit
class LogInController: UIViewController{
//    let usernameField = UITextField()
//    let passwordField = UITextField()
//    let emailField = UITextField()
//    let logInBtn = UIButton()
  
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
   
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var logInBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        logInBtn.layer.cornerRadius = logInBtn.frame.height / 2
        signUpBtn.layer.cornerRadius = signUpBtn.frame.height / 2

//        usernameField.placeholder = "Username"
//        passwordField.placeholder = "Password"
//        emailField.placeholder = "Email"
//        logInBtn.setTitle("Log In", for: .normal)
//        self.view.addSubview(usernameField)
////        self.view.addSubview(emailField)
//        self.view.addSubview(passwordField)
//        self.view.addSubview(logInBtn)
//        NSLayoutConstraint.activate([usernameField.widthAnchor.constraint(equalTo: self.view.widthAnchor),usernameField.heightAnchor.constraint(equalToConstant: 30),usernameField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),usernameField.centerYAnchor.constraint(equalTo: self.passwordField.centerYAnchor,constant: -60)])
//        NSLayoutConstraint.activate([passwordField.widthAnchor.constraint(equalTo: self.view.widthAnchor),passwordField.heightAnchor.constraint(equalToConstant: 30),passwordField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),passwordField.centerYAnchor.constraint(equalTo: logInBtn.centerYAnchor, constant: -60)])
//        NSLayoutConstraint.activate([logInBtn.widthAnchor.constraint(equalToConstant: 100),logInBtn.heightAnchor.constraint(equalToConstant: 40), logInBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),logInBtn.centerYAnchor.constraint(equalTo: self.view.centerYAnchor,constant: 70)])
        
    }
    @IBAction func logInAction(_ sender: Any) {
        
        router.logon(email: emailField.text ?? "0", password: passwordField.text ?? "0", handler: { status, user, err in
            //
            if (status == StatusCode.complete && err.isEmpty){
                
                let profileCont = self.storyboard?.instantiateViewController(withIdentifier: "ProfileContainer") as! ProfileController
                    profileCont.NameLabel.text = user.email
                    self.navigationController?.present(profileCont, animated: true, completion: {})
                
            }else {
                        DispatchQueue.main.async {
                            let ac = UIAlertController(title: "Error", message: "Incorrect Log In", preferredStyle: .alert)
                            ac.addAction( UIAlertAction(title: "Ok", style: .default))
                            self.present(ac, animated: true, completion: {})
                    }
                   
                }
            
            
        })
    }
    
    required init(){
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    
        
        
    }
    
}
