//
//  Page.swift
//  mulp
//
//  Created by Christian Jimenez on 6/21/21.
//


import UIKit

class Page {
    var id:String = ""
    var pic:UIImage = UIImage(named: "TheNerves")!
    var path:String = "" {didSet{
        DispatchQueue.global().async { [self] in
            let url = URL(string: path)
            if let data = try? Data(contentsOf: url!) {
                if let image = UIImage(data: data){
                        pic = image
                    }
            }}}}
    var approvalScore = 0
    
    init(id: String,pic:UIImage) {
        self.id = id
        self.pic = pic
        
    }
        func like(){
            approvalScore += 1
        }
        func dislike(){
            approvalScore -=  1
        }
    
    
}
