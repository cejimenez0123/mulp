//
//  BookMakerCollectionViewCell.swift
//  mulp
//
//  Created by Christian Jimenez on 4/17/22.
//

import Foundation
import UIKit

class BookMakerCollectionViewCell:UICollectionViewCell{
    var page = Page(id: "", path: "", type: ""){
        didSet {
            imageView.downloaded(from: page.path)
            image = imageView.image ?? UIImage(named: "TheNerves")!
        }
    }
    var image:UIImage=UIImage()
    override var isSelected: Bool {
        didSet{if (self.isSelected){
          let img =  imageView.image?.adjustExposure(byVal: 3)
            imageView.image? = img ?? imageView.image!
            
        }else{
            if image.size.width != 0 {
                imageView.image = image}
        }}
    }
    @IBOutlet weak var checkmark: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    override init(frame: CGRect) {
        super.init(frame: frame)
//     let tap =   UITapGestureRecognizer(target: self, action: #selector(forSelection))
        imageView.isUserInteractionEnabled = false
//        tap.cancelsTouchesInView = false
//        self.addGestureRecognizer(tap)
        self.isUserInteractionEnabled = true
//  let img = UIImage(systemName: "checkmark.rectangle.fill")
//        checkmark.setImage(img, for: .selected)
//        checkmark.addTarget(self, action: #selector(selection), for: .touchDown)
    }
    @objc func forSelection(){
        
        
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
//    override var isSelected: Bool {
//        didSet {
//            if (self.isSelected==true){
//                checkmark.setImage(UIImage(systemName: "checkmark.rectangle.fill"), for: .selected)
//               let img = imageView.image?.adjustSaturation(byVal: -10)
//                imageView.image = img
//                
//            }else{
//               let img = imageView.image?.adjustSaturation(byVal: 0)
//                imageView.image = img
//                checkmark.setImage(UIImage(systemName: "checkmark.rectangle.fill"), for: .selected)
//                
//            }
//        }
        
        
//    }
    
}

