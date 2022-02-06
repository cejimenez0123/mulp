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
    }
    @objc func logOn(){
        guard let url = URL(string: "\(globalVars.path)/logon") else {return}
        var request = URLRequest(url: url)
        let session = URLSession.shared
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
            "username": usernameField.text ?? "0",
            "password": passwordField.text ?? ""
        ]
        do {
               request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
           } catch let error {
               print(error.localizedDescription)
           }

        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in

                guard error == nil else {
                    return
                }

                guard let data = data else {
                    return
                }
                do {
                    //create json object from data
                    if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                        print(json)
                        // handle json...
                        
                        
                        print(json)
                    }
                } catch let error {
                    print(error.localizedDescription)
                }
            })
            task.resume()
    }
    required init(){
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    
        
        
    }
    
}
