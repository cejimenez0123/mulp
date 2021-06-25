//
//  PageTableViewCell.swift
//  mulp
//
//  Created by Christian Jimenez on 6/21/21.
//

import UIKit


class PageTableViewCell: UITableViewCell{
  
    @IBOutlet weak var pic: UIImageView!
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        
        
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        self.imageView!.image = pict
//        self.imageView!.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([self.imageView!.topAnchor.constraint(equalTo: self.topAnchor),self.bottomAnchor.constraint(equalTo: self.bottomAnchor),self.imageView!.rightAnchor.constraint(equalTo: self.rightAnchor),self.imageView!.leftAnchor.constraint(equalTo: self.leftAnchor)])
    }
    required init?(coder: NSCoder) {
        super.init(coder:  coder)
    }
}
