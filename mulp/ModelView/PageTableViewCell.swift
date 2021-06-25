//
//  PageTableViewCell.swift
//  mulp
//
//  Created by Christian Jimenez on 6/21/21.
//

import UIKit


class PageTableViewCell: UITableViewCell{
   var pic: UIImageView = UIImageView(image: UIImage(named: "TheNerves")
)
    
    init(pict:UIImageView,style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.pic = pict
        
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(self.pic)
        
        NSLayoutConstraint.activate([self.pic.topAnchor.constraint(equalTo: self.topAnchor),self.bottomAnchor.constraint(equalTo: self.bottomAnchor),self.pic.rightAnchor.constraint(equalTo: self.rightAnchor),self.pic.leftAnchor.constraint(equalTo: self.leftAnchor)])
    }
    required init?(coder: NSCoder) {
        super.init(coder:  coder)
    }
}
