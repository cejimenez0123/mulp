//
//  PageTableViewCell.swift
//  mulp
//
//  Created by Christian Jimenez on 6/21/21.
//

import UIKit


class PageTableViewCell: UITableViewCell{
  
    var pic = UIImageView()
    var actionBox = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(pic)
        self.addSubview(actionBox)
        pic.translatesAutoresizingMaskIntoConstraints=false
    
        actionBox.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([pic.topAnchor.constraint(equalTo: self.topAnchor),pic.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -55),pic.leftAnchor.constraint(equalTo: self.leftAnchor),pic.rightAnchor.constraint(equalTo: self.rightAnchor)])
        NSLayoutConstraint.activate([actionBox.topAnchor.constraint(equalTo: pic.bottomAnchor),
            actionBox.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            actionBox.leftAnchor.constraint(equalTo:self.leftAnchor),
            actionBox.rightAnchor.constraint(equalTo: self.rightAnchor)])
        
        let approvalBtns = UIView()
            approvalBtns.translatesAutoresizingMaskIntoConstraints = false
        let yeahBtn = UIButton()
            yeahBtn.translatesAutoresizingMaskIntoConstraints = false
        let nahBtn = UIButton()
            nahBtn.translatesAutoresizingMaskIntoConstraints = false
            yeahBtn.setTitle("Yeah", for: .normal)
            nahBtn.setTitle("Nah",for: .normal)
            approvalBtns.backgroundColor = .green
        actionBox.addSubview(approvalBtns)
        NSLayoutConstraint.activate([
            approvalBtns.leftAnchor.constraint(equalTo: actionBox.leftAnchor),approvalBtns.rightAnchor.constraint(equalTo: approvalBtns.leftAnchor,constant: 100),approvalBtns.topAnchor.constraint(equalTo: actionBox.topAnchor),approvalBtns.bottomAnchor.constraint(equalTo: actionBox.bottomAnchor)])
        approvalBtns.addSubview(yeahBtn)
        approvalBtns.addSubview(nahBtn)
        NSLayoutConstraint.activate([yeahBtn.leftAnchor.constraint(equalTo: approvalBtns.leftAnchor),yeahBtn.rightAnchor.constraint(equalTo: approvalBtns.leftAnchor,constant: 60),yeahBtn.topAnchor.constraint(equalTo: approvalBtns.topAnchor), yeahBtn.bottomAnchor.constraint(equalTo: approvalBtns.bottomAnchor)])
        NSLayoutConstraint.activate([nahBtn.leftAnchor.constraint(equalTo: yeahBtn.rightAnchor),nahBtn.rightAnchor.constraint(equalTo: approvalBtns.rightAnchor),nahBtn.topAnchor.constraint(equalTo: approvalBtns.topAnchor),nahBtn.bottomAnchor.constraint(equalTo: approvalBtns.bottomAnchor)])
        let commentBtn = UIButton()
        commentBtn.setTitle("Comment", for: .normal)
        commentBtn.backgroundColor = .black
        commentBtn.translatesAutoresizingMaskIntoConstraints = false
        actionBox.addSubview(commentBtn)
        NSLayoutConstraint.activate([commentBtn.widthAnchor.constraint(equalTo: actionBox.widthAnchor, multiplier: 0.30),commentBtn.heightAnchor.constraint(equalTo: actionBox.heightAnchor),commentBtn.centerYAnchor.constraint(equalTo: commentBtn.centerYAnchor),commentBtn.centerXAnchor.constraint(equalTo: actionBox.centerXAnchor)])
        let shareBtn = UIButton()
        shareBtn.setTitle("Share", for: .normal)
        shareBtn.backgroundColor = .black
        shareBtn.translatesAutoresizingMaskIntoConstraints=false
        actionBox.addSubview(shareBtn)
        NSLayoutConstraint.activate([shareBtn.topAnchor.constraint(equalTo: actionBox.topAnchor),shareBtn.bottomAnchor.constraint(equalTo: actionBox.bottomAnchor),shareBtn.leftAnchor.constraint(equalTo: commentBtn.rightAnchor,constant: 2),shareBtn.rightAnchor.constraint(equalTo: commentBtn.rightAnchor, constant: 100)])
//                                        approvalBtns.widthAnchor.constraint(equalTo: actionBox.widthAnchor, multiplier: 0.36),
//                                        approvalBtns.heightAnchor.constraint(equalTo: actionBox.heightAnchor),
//                                           approvalBtns.leftAnchor.constraint(equalTo: ),approvalBtns.centerXAnchor.constraint(equalTo:actionBox.leftAnchor,constant: 80)]
    }
    required init?(coder: NSCoder) {
        super.init(coder:  coder)
    }
}
