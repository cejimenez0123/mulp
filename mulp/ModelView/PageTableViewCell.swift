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
    }
    required init?(coder: NSCoder) {
        super.init(coder:  coder)
    }
}
