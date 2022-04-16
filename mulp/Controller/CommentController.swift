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

class CommentController:UITableViewController,  UITextFieldDelegate {
    let comBtn = UIButton(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width , height: 50))
    var footerView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 80))
    let textField = UITextField(frame: CGRect(x: 0, y: 20, width: UIScreen.main.bounds.width, height:70))
    let commentBoxView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height:90))
    let commentBtn =  UIButton(frame: CGRect(x: 110 , y: 0, width: UIScreen.main.bounds.width/2, height: 20))
    let cancelBtn = UIButton(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width / 2, height: 20))
    let btnView = UIView(frame: CGRect(x: 0, y:0, width:UIScreen.main.bounds.width, height: 20))
    var comments = [Comment](){didSet{
        tableView.reloadData()
    }}
    let comClient = CommentClient()
    var page = Page(id: "", path: "", type: ""){
        didSet{
            imageView.downloaded(from: page.path)
        }
    }
    
    var contentView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 150))

    var imageView = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
     let inset =   UIEdgeInsets(top: 120, left: 0, bottom: 0, right: 0)
        self.tableView.contentInset = inset
        self.tableView.scrollIndicatorInsets = inset
        commentClient.getCommentsOfPage(page_id: page.id, handler: { comm in

            DispatchQueue.main.async {
                
                self.comments = comm
                self.tableView.reloadData()
            }
        })

        let bounds = UIScreen.main.bounds
        btnView.addSubview(commentBtn)
        btnView.addSubview(cancelBtn)
        if imageView.image == nil {
           let h = imageView.image?.heightRatio() ?? 100
    let ah = bounds.width / h
            imageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: ah)
            contentView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: ah)
        } else{
           let img = UIImage(named: "TheNerves")!
            let ah =  bounds.width / img.heightRatio()
            imageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: ah)
            }
        self.tableView.isScrollEnabled = true
    
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let img = imageView.image ?? UIImage(named: "TheNerves")!
            
        let h = UIScreen.main.bounds.width / img.heightRatio()
        return h / 2
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        contentView.addSubview(imageView)
                return contentView
    }
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
       
       
        comBtn.isUserInteractionEnabled = true
        comBtn.setTitle("Comment", for: .normal)
        comBtn.setTitleColor(.white, for: .normal)
        comBtn.backgroundColor = .black
      
    
        footerView.addSubview(comBtn)
            return footerView

    }
    @objc func showCommentingBox(){

       
        footerView.frame.size.height = 90
        
      
        btnView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
        
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
        
        if (commentBtn.isTouchInside || self.textField.isHidden ) {
            self.textField.isHidden = true
            return true
        } else if(cancelBtn.isTouchInside){
            self.textField.isHidden = true
            self.comBtn.isHidden = false
            return true
        }else{
            return false
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
   
    @objc func postComment(){
        let text = textField.text ?? ""
        self.view.endEditing(true)
        textField.isHidden = true
        btnView.isHidden = true
        footerView.isHidden = false
        comBtn.isHidden = false
        comClient.postComment(text: text, page_id: page.id, user_id: globalVars.currentUser.id, handler: { [self]com in
            self.comments.insert(com, at: 0)
            DispatchQueue.main.async {
                self.tableView.reloadData()
               
                
               
            }
        })
        
    }
    override func viewDidLayoutSubviews() {
    
                super.viewWillLayoutSubviews()
        cancelBtn.addTarget(self, action: #selector(cancelCommenting), for: .touchUpInside)
        comBtn.addTarget(self, action: #selector(showCommentingBox), for: .touchUpInside)
        
    }
    @objc func cancelCommenting(){
        self.view.endEditing(true)
        btnView.isHidden = true
        textField.isHidden = true
        comBtn.isHidden = false
       
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentTableViewCell") as! CommentTableViewCell
//       let com = comments[indexPath.row]
//        cell.setCellData(comment: com)
//        cell.commentView.textContainer.lineFragmentPadding = 0
//
        let cell = self.tableView(self.tableView, cellForRowAt: indexPath) as! CommentTableViewCell
        
        let fixedWidth = self.tableView.frame.size.width - 10
        let newSize = cell.commentView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        cell.commentView.frame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
        
        return cell.commentView.frame.height + 30
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let nib = UINib(nibName: "CommentTableViewCell", bundle: Bundle(for: CommentTableViewCell.self))
        tableView.register(nib, forCellReuseIdentifier: "CommentTableViewCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentTableViewCell") as! CommentTableViewCell
        let comment =  self.comments[indexPath.row]
        cell.commentView.isScrollEnabled = false
        cell.setCellData(comment: comment)
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return comments.count
    }
    
    func setComments(commentsArr:[Comment]){
        self.comments = commentsArr
    }
}

