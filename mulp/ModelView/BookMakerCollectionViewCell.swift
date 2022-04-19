//
//  BookMakerCollectionViewCell.swift
//  mulp
//
//  Created by Christian Jimenez on 4/17/22.
//

import Foundation
import UIKit

class BookMakerCollectionViewCell:UICollectionViewCell{
    var page = Page(id: "", path: "", type: "")
    @IBOutlet weak var imageView: UIImageView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.downloaded(from: page.path)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override var isSelected: Bool {
        didSet {
            if (self.isSelected==true){
                
            }else{
                
                
            }
        }
        
        
    }
    
}

