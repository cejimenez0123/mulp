//
//  PageTableViewCell.swift
//  mulp
//
//  Created by Christian Jimenez on 6/21/21.
//

import UIKit


class PageTableViewCell: UITableViewCell{
    var pageId = ""
    @IBOutlet weak var pic: UIImageView!
    var page = Page(id: "", path: "https://townsquare.media/site/838/files/2019/09/slowthai-musichallofwb-55.jpg", type: "")
    @IBOutlet weak var actionbox: UIView!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var commentBtn: UIButton!
    @IBOutlet weak var nahBtn: UIButton!
    @IBOutlet weak var yeahBtn: UIButton!
    var cellHeight:CGFloat  = 200
    var parentController:UITableViewController?
    var approval = 0
    let commentClient = CommentClient()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
   
        
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        actionbox.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        actionbox.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
    func setCellData(page:Page){
        self.pic.downloaded(from: page.path)
       
    }
    func setCellHeight(){
        let r = self.pic.image?.heightRatio() ?? 1.0
        cellHeight =  (UIScreen.main.bounds.width / r) + 400
        
    }
    
   required init?(coder: NSCoder){
        super.init(coder:coder)

  
   


        self.isUserInteractionEnabled = true
        
      
           

        
        
    }
    

    override func layoutSubviews() {
        super.layoutSubviews()
        
        yeahBtn.addTarget(self, action: #selector(approvalBtnClick(_:)), for: .touchUpInside)
        nahBtn.addTarget(self, action: #selector(approvalBtnClick(_:)), for: .touchUpInside)
        
       commentBtn.addTarget(self, action: #selector(didPressCommentButton(sender:)), for: .touchUpInside)
    }

    
    @objc func didPressCommentButton(sender: Any?){
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
//        let conController =  storyboard.instantiateViewController(withIdentifier: "ContentController") as! ContentController
//        conController.page = self.page
        if self.isSelected == true {
        let commController = storyboard.instantiateViewController(withIdentifier: "CommentController") as! CommentController
        commController.page = page
        self.parentController?.navigationController?.pushViewController(commController, animated: true)
            commentClient.getCommentsOfPage(page_id: self.page.id, handler: {comms in
                DispatchQueue.main.async {
                    commController.comments = comms
                }
                
            }
            )
            
        }
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
 
