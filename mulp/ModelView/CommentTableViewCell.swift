//
//  CommentTableViewCell.swift
//  mulp
//
//  Created by Christian Jimenez on 2/19/22.
//

import Foundation
import UIKit

class CommentTableViewCell: UITableViewCell{
//    let commentView = UITextView()
//    let usernameView = UILabel()
    @IBOutlet weak var usernameView: UILabel!
    
    @IBOutlet weak var commentView: UITextView!
    var commentId = ""
    var user = User(id:"",email:"",username:"")
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
   
        
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commentView.isScrollEnabled = false
    }
    
    func setCellData(comment: Comment){
       user = comment.user
        commentId = comment.id
        self.contentView.addSubview(commentView)
        self.contentView.addSubview(usernameView)
  
        
        commentView.text = comment.text
        commentView.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        commentView.textContainer.lineFragmentPadding = 0
        usernameView.text = comment.user.username
    
            }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
       
  
        
    }
}
