//
//  SignUpController.swift
//  mulp
//
//  Created by Christian Jimenez on 7/7/21.
//

import Foundation
import UIKit
import SwiftyJSON

class SignUpController: UIViewController{
    let usernameField = UITextField()
    var user = User(id: "0",email: "", username: "")
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
        signUpBtn.addTarget(self, action: #selector(signOn(_sender:)), for: .touchUpInside)
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
    @objc func signOn(_sender: Any?){
        
        
        guard let url = URL(string: "\(globalVars.path)/users") else {return}
        var request = URLRequest(url: url)
       
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "POST"
        let parameters:NSDictionary = [
            "id": "\(UUID())",
            "username": self.usernameField.text!,
            "email": self.emailField.text!,
            "password": self.passwordField.text!
        ]
        let jsonData = try? JSONSerialization.data(withJSONObject:parameters)
      
            request.timeoutInterval = 10
        request.httpBody = jsonData
        print("!")
        URLSession.shared.dataTask(with: request) {(data,response,error) -> Void in
                print("@")
            if let data = data, error == nil {
                   
            let json = JSON(data)
            if error != nil{ print(json.error?.rawValue ?? "No Error")}
                let att = json["data"]["attributes"]["username"]
                print(json["data"]["attributes"])
                
                self.user.username = att["username"].stringValue
                self.user.email = att["email"].stringValue
                self.user.id = att["id"].stringValue
            } else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            
        }.resume()
        
//        let profileCont = self.storyboard?.instantiateViewController(identifier: "ProfileController") as! ProfileController
        globalVars.currentUser.email = self.user.email
        globalVars.currentUser.username = self.user.username
        globalVars.currentUser.id = self.user.id
        print("Currentuser",globalVars.currentUser.username)
        self.navigationController?.popToRootViewController(animated: true)
        }
    @objc func dismissAction(_ sender: Any?){
        
        dismiss(animated: true, completion: nil)
    }
        func completionHandler(truthy:Bool,info:Any)->Void{
            print(info)
        }
    
}
