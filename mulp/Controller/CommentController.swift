//
//  CommentController.swift
//  mulp
//
//  Created by Christian Jimenez on 4/2/22.
//

import Foundation
import UIKit
import IQKeyboardManager
//

class CommentController:UITableViewController,  UITextFieldDelegate{
    let comBtn = UIButton(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width / 2.0, height: 60))
    var footerView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 80))
    let textField = UITextField(frame: CGRect(x: 0, y: 20, width: UIScreen.main.bounds.width, height:70))
    let commentBoxView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height:90))
    var page  = Page(id: "", path: "", type: "")
    let commentBtn =  UIButton(frame: CGRect(x: 110 , y: 0, width: UIScreen.main.bounds.width/2, height: 20))
    let cancelBtn = UIButton(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width / 2, height: 20))
    var comments = [Comment]() {didSet{
        self.tableView.reloadData()
    }}
    let comClient = CommentClient()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        commentClient.getCommentsOfPage(page_id: page.id, handler: { comm in

            DispatchQueue.main.async {
                self.comments = comm
                self.tableView.reloadData()
            }
        })
    
        self.view.backgroundColor = .black

    
    }
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
       
       
        comBtn.isUserInteractionEnabled = true
        comBtn.setTitle("Comment", for: .normal)
        comBtn.setTitleColor(.black, for: .normal)
        comBtn.backgroundColor = .white
        comBtn.addTarget(self, action: #selector(showCommentingBox), for: .touchUpInside)
    
        footerView.addSubview(comBtn)
//        if comBtn.isTouchInside {
//           let textField = UITextField.init(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 70))
//            footerView.frame.size.height = 100
//            footerView.addSubview(textField)
//            return footerView
//        }else{
//
       
            footerView.backgroundColor = UIColor.blue
            return footerView
//        }
    }
    @objc func showCommentingBox(){

       
        footerView.frame.size.height = 90
        
       let btnView = UIView(frame: CGRect(x: 0, y:0, width: tableView.frame.size.width, height: 20))
        btnView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
        btnView.addSubview(commentBtn)
        btnView.addSubview(cancelBtn)
        cancelBtn.setTitle("Cancel", for: .normal)
        commentBtn.setTitle("Comment", for: .normal)
        commentBtn.setTitleColor(.white, for: .normal)
        cancelBtn.setTitleColor(.white, for: .normal)
        commentBtn.addTarget(self, action: #selector(postComment), for: .touchUpInside)
       
        commentBoxView.addSubview(btnView)
        textField.isUserInteractionEnabled = true
        textField.placeholder = "Comment"
        textField.backgroundColor = .white
        textField.delegate = self
        textField.becomeFirstResponder()
        comBtn.isHidden = true
        footerView.addSubview(btnView)
        footerView.addSubview(textField)
       
        
        
        
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("YOOOO \(self.textField.isHidden)")
        if commentBtn.isTouchInside || cancelBtn.isTouchInside {
            
            return true
        }else{return false
            
            
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    @objc func postComment(){
        let text = textField.text ?? ""
       
        commentBoxView.isHidden = true
        comBtn.isHidden = false
        comClient.postComment(text: text, page_id: page.id, user_id: globalVars.currentUser.id, handler: { [self]com in
            self.comments.append(com)
            DispatchQueue.main.async {
                self.tableView.reloadData()
                
            }
        })
        
    }
    override func viewDidLayoutSubviews() {
    
                super.viewWillLayoutSubviews()
        
            
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let nib = UINib(nibName: "CommentTableViewCell", bundle: Bundle(for: CommentTableViewCell.self))
        tableView.register(nib, forCellReuseIdentifier: "CommentTableViewCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentTableViewCell") as! CommentTableViewCell
        let comment =  self.comments[indexPath.row]
        
        cell.setCellData(comment: comment)
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func setComments(commentsArr:[Comment]){
        self.comments = commentsArr}
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cell = tableView.cellForRow(at: indexPath)
        as! CommentTableViewCell
        let fixedWidth = cell.commentView.frame.size.width - 10
        let newSize = cell.commentView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        return newSize.height + 30
    }

