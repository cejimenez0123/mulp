//
//  PageTableViewCell.swift
//  mulp
//
//  Created by Christian Jimenez on 6/21/21.
//

import UIKit


class PageTableViewCell: UITableViewCell{
    var pageId = ""
    var page:Page = Page(id: "0", path: "https://www.planetware.com/wpimages/2020/02/france-in-pictures-beautiful-places-to-photograph-eiffel-tower.jpg", type: "image")
    var pic = UIImageView()
    var picture = UIImage(named: "TheNerves"){
        didSet{
            pic.image = picture
        }
    }
    var parentController:UITableViewController?
    var approval = 0
    var actionBox = UIView()
    let yeahBtn = UIButton()
    let nahBtn = UIButton()
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
   
        
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)

    }
 
   required init?(coder: NSCoder){
        super.init(coder:coder)
//        fatalError("init(coder:) has not been implemented")
        actionBox.translatesAutoresizingMaskIntoConstraints = false
       pic.downloaded(from: page.path)
       pic.translatesAutoresizingMaskIntoConstraints = false
       self.contentView.addSubview(pic)
       self.contentView.addSubview(actionBox)
        
           
   
        
       NSLayoutConstraint.activate([pic.topAnchor.constraint(equalTo: self.topAnchor),pic.bottomAnchor.constraint(equalTo: actionBox.topAnchor),pic.leftAnchor.constraint(equalTo: self.leftAnchor),pic.rightAnchor.constraint(equalTo: self.rightAnchor)])
       NSLayoutConstraint.activate([actionBox.heightAnchor.constraint(equalToConstant:50),
                                    actionBox.widthAnchor.constraint(equalTo: self.widthAnchor),
                                    actionBox.centerYAnchor.constraint(equalTo: self.bottomAnchor, constant: -25),
                                    actionBox.centerXAnchor.constraint(equalTo: self.centerXAnchor)])
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
        self.isUserInteractionEnabled = true
        
        actionBox.addSubview(yeahBtn)
        actionBox.addSubview(nahBtn)
            NSLayoutConstraint.activate([yeahBtn.leftAnchor.constraint(equalTo: actionBox.leftAnchor),yeahBtn.rightAnchor.constraint(equalTo: actionBox.leftAnchor,constant: 55),yeahBtn.topAnchor.constraint(equalTo: actionBox.topAnchor), yeahBtn.bottomAnchor.constraint(equalTo: actionBox.bottomAnchor)])
        NSLayoutConstraint.activate([nahBtn.leftAnchor.constraint(equalTo: yeahBtn.rightAnchor,constant: 1),nahBtn.rightAnchor.constraint(equalTo: commentBtn.leftAnchor,constant: -1),nahBtn.topAnchor.constraint(equalTo: actionBox.topAnchor),nahBtn.bottomAnchor.constraint(equalTo: actionBox.bottomAnchor)])


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

        
        self.yeahBtn.addTarget(self, action: #selector(approvalBtnClick(_:)), for: .touchUpInside)
        self.nahBtn.addTarget(self, action: #selector(approvalBtnClick(_:)), for: .touchUpInside)
        commentBtn.addTarget(self, action: #selector(commentsSegue(_:)), for: .touchUpInside)
    }
    

    

    
  
    @objc func commentsSegue(_ sender: UIButton){
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
        let commentController =  storyboard.instantiateViewController(withIdentifier: "CommentController") as! CommentController
        commentController.page = self.page
        
       
        self.parentController?.navigationController?.present(commentController, animated: true)
    }
 
    @objc func approvalBtnClick(_ sender: UIButton){
        print("HELLO WAH WAH")
        if globalVars.userLoggedIn{
        switch sender {
        case yeahBtn:
            yeahBtn.backgroundColor = .green
            approval = 1
        case  nahBtn:
            nahBtn.backgroundColor = .yellow
            approval = -1
        default:
            approval = 0
                }
       
           
            }else{
               let alert = UIAlertController(title: "Sign Up", message: "If not already, please log in or sign up to vote", preferredStyle: .alert)

                let logInAction = UIAlertAction(title: "Log In", style: .default, handler:{(_ action: UIAlertAction) -> Void in
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let liController = storyBoard.instantiateViewController(identifier: "LogInController") as! LogInController
                    self.parentController?.navigationController?.show(liController, sender: self)
                })

                let signUpAction = UIAlertAction(title: "Sign Up", style: .default,handler:{ UIAlertAction->Void in
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let suController = storyBoard.instantiateViewController(withIdentifier: "SignUpController") as! SignUpController
                    self.parentController?.navigationController?.show(suController, sender: self)

                })
                alert.addAction(signUpAction)
                alert.addAction(logInAction)
                self.parentController?.present(alert, animated: true, completion: nil)
}
    }
    
}
//extension UIView {
//    var parentViewController: UIViewController? {
//        var parentResponder: UIResponder? = self
//        while parentResponder != nil {
//            parentResponder = parentResponder!.next
//            if parentResponder is UIViewController {
//                return parentResponder as? UIViewController
//            }
//        }
//        return nil
//    }
//}
 
