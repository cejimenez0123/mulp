//
//  PageTableViewCell.swift
//  mulp
//
//  Created by Christian Jimenez on 6/21/21.
//

import UIKit


class PageTableViewCell: UITableViewCell{
    var page:Page = Page(id:"0", pic: UIImage(named: "TheNerves")!)
    var pic: UIImageView = UIImageView()
    var approval = 0
    var actionBox = UIView()
    let yeahBtn = UIButton()
    let nahBtn = UIButton()
   override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
   
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    
    yeahBtn.addTarget(self, action: #selector(approveBtnClick), for: .touchUpInside)
    
        pic = UIImageView(image: page.pic)
        self.addSubview(pic)
        self.addSubview(actionBox)
        pic.translatesAutoresizingMaskIntoConstraints=false
    
        actionBox.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([pic.topAnchor.constraint(equalTo: self.topAnchor),pic.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -55),pic.leftAnchor.constraint(equalTo: self.leftAnchor),pic.rightAnchor.constraint(equalTo: self.rightAnchor)])
        NSLayoutConstraint.activate([actionBox.topAnchor.constraint(equalTo: pic.bottomAnchor),
            actionBox.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            actionBox.leftAnchor.constraint(equalTo:self.leftAnchor),
            actionBox.rightAnchor.constraint(equalTo: self.rightAnchor)])
        let commentBtn = UIButton()
        commentBtn.setTitle("Comment", for: .normal)
        commentBtn.backgroundColor = .black
        commentBtn.translatesAutoresizingMaskIntoConstraints = false
        let approvalBtns = UIView()
            approvalBtns.translatesAutoresizingMaskIntoConstraints = false
        
            yeahBtn.translatesAutoresizingMaskIntoConstraints = false
        
            nahBtn.translatesAutoresizingMaskIntoConstraints = false
            yeahBtn.setTitle("Yeah", for: .normal)
            nahBtn.setTitle("Nah",for: .normal)
        yeahBtn.backgroundColor = .black
        nahBtn.backgroundColor = .black
        actionBox.addSubview(commentBtn)
        actionBox.addSubview(approvalBtns)
        NSLayoutConstraint.activate([
        approvalBtns.leftAnchor.constraint(equalTo: actionBox.leftAnchor),approvalBtns.rightAnchor.constraint(equalTo: commentBtn.leftAnchor,constant: -1),approvalBtns.topAnchor.constraint(equalTo: actionBox.topAnchor),approvalBtns.bottomAnchor.constraint(equalTo: actionBox.bottomAnchor)])
        approvalBtns.addSubview(yeahBtn)
        approvalBtns.addSubview(nahBtn)
        NSLayoutConstraint.activate([yeahBtn.leftAnchor.constraint(equalTo: approvalBtns.leftAnchor),yeahBtn.rightAnchor.constraint(equalTo: approvalBtns.leftAnchor,constant: 50),yeahBtn.topAnchor.constraint(equalTo: approvalBtns.topAnchor), yeahBtn.bottomAnchor.constraint(equalTo: approvalBtns.bottomAnchor)])
        NSLayoutConstraint.activate([nahBtn.leftAnchor.constraint(equalTo: yeahBtn.rightAnchor,constant: 1),nahBtn.rightAnchor.constraint(equalTo: approvalBtns.rightAnchor),nahBtn.topAnchor.constraint(equalTo: approvalBtns.topAnchor),nahBtn.bottomAnchor.constraint(equalTo: approvalBtns.bottomAnchor)])
       
        
        NSLayoutConstraint.activate([commentBtn.widthAnchor.constraint(equalTo: actionBox.widthAnchor, multiplier: 0.30),commentBtn.heightAnchor.constraint(equalTo: actionBox.heightAnchor),commentBtn.centerYAnchor.constraint(equalTo: commentBtn.centerYAnchor),commentBtn.centerXAnchor.constraint(equalTo: actionBox.centerXAnchor,constant: -20)])
        let shareBtn = UIButton()
        shareBtn.setTitle("Share", for: .normal)
        shareBtn.backgroundColor = .black
        shareBtn.translatesAutoresizingMaskIntoConstraints=false
        actionBox.addSubview(shareBtn)
        let addBtn = UIButton()
        addBtn.setTitle("+", for: .normal)
        addBtn.translatesAutoresizingMaskIntoConstraints = false
        addBtn.backgroundColor = .black
        
        actionBox.addSubview(addBtn)
        NSLayoutConstraint.activate([shareBtn.topAnchor.constraint(equalTo: actionBox.topAnchor),shareBtn.bottomAnchor.constraint(equalTo: actionBox.bottomAnchor),shareBtn.leftAnchor.constraint(equalTo: addBtn.rightAnchor,constant: 1),shareBtn.rightAnchor.constraint(equalTo: actionBox.rightAnchor)])
        
        NSLayoutConstraint.activate([addBtn.leftAnchor.constraint(equalTo: commentBtn.rightAnchor,constant: 1),addBtn.rightAnchor.constraint(equalTo: addBtn.leftAnchor,constant: 50),addBtn.topAnchor.constraint(equalTo: actionBox.topAnchor),addBtn.bottomAnchor.constraint(equalTo: actionBox.bottomAnchor)])
    }
    
  
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func approveBtnClick(_ sender: UIButton, score:Int){
        if sender == yeahBtn{
            if globalVars.userLoggedIn{
                //            let url = URL(string: "http://localhost:3000/likes")
                //            var request = URLRequest(url: url!)
                //            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
                //            request.httpMethod = "POST"
                //            let parameters: [String: Any] = [
                //                "id": 13,
                //                "name": "Jack & Jill"
                //            ]
                //            request.httpBody = parameters.percentEncoded()
                //
                //            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                //                guard let data = data,
                //                    let response = response as? HTTPURLResponse,
                //                    error == nil else {                                              // check for fundamental networking error
                //                    print("error", error ?? "Unknown error")
                //                    return
                //                }
                //
                //                guard (200 ... 299) ~= response.statusCode else {                    // check for http errors
                //                    print("statusCode should be 2xx, but is \(response.statusCode)")
                //                    print("response = \(response)")
                //                    return
                //                }
                //
                //                let responseString = String(data: data, encoding: .utf8)
                //                print("responseString = \(responseString)")
                //            }
                //
                //            task.resume()
            }else{
               let alert = UIAlertController(title: "Sign Up", message: "If not already, please log in or sign up to vote", preferredStyle: .alert)
                
                let action = UIAlertAction(title: "Log In", style: .default, handler:{(_ action: UIAlertAction) -> Void in
                    /** What we write here???????? **/
                    print("you pressed Yes, please button")
                    
                    // call method whatever u need
                })
                alert.addAction(action)
            }
            yeahBtn.backgroundColor = .green
            approval = 1
            page.approvalScore += score

        }
    }
}
