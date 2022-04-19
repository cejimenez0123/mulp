//
//  CollectionViewCell.swift
//  mulp
//
//  Created by Christian Jimenez on 4/17/22.
//

import Foundation
import UIKit


class CollectionViewCell:UICollectionViewCell{
    var page = Page(id: "0", path: "", type: "")
    @IBOutlet weak var imageView: UIImageView!
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        imageView.downloaded(from: page.path)
    }
    
}
