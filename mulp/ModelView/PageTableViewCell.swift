//
//  PageTableViewCell.swift
//  mulp
//
//  Created by Christian Jimenez on 6/21/21.
//

import UIKit


class PageTableViewCell: UITableViewCell{
  
    var pic = UIImageView()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(pic)
        pic.translatesAutoresizingMaskIntoConstraints=false
        NSLayoutConstraint.activate([pic.topAnchor.constraint(equalTo: self.topAnchor),pic.bottomAnchor.constraint(equalTo: self.bottomAnchor),pic.leftAnchor.constraint(equalTo: self.leftAnchor),pic.rightAnchor.constraint(equalTo: self.rightAnchor)])
        

    }
    required init?(coder: NSCoder) {
        super.init(coder:  coder)
    }
}
