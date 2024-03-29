//
//  Page.swift
//  mulp
//
//  Created by Christian Jimenez on 6/21/21.
//


import UIKit
import SwiftyJSON

class Page:Hashable{
    static func == (lhs: Page, rhs: Page) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name && lhs.path == rhs.path && lhs.approvalScore == rhs.approvalScore && lhs.user == rhs.user && lhs.type == rhs.type && rhs.published == lhs.published && rhs.privacy == lhs.privacy
    }
    
 
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
        hasher.combine(path)
        hasher.combine(approvalScore)
        hasher.combine(user)
        hasher.combine(type)
        hasher.combine(published)
        hasher.combine(privacy)
    }
   
    
    var id:String = ""
    var name:String = ""
    var path:String = "" 
    var approvalScore = 0
    var user = User(id: "", email: "", username: "",name:"")
    var type:String = ""
    var published: Bool = true
    var privacy: Bool = false
    
    init(id: String,path:String,type:String) {
        self.id = id
        self.path = path
        self.type = type
        
    }
        func like(){
            approvalScore += 1
        }
        func dislike(){
            approvalScore -=  1
        }
    
    
}

//extension  UIImage {
//    
//   class func downloaded(from urlstr: String, handler:@escaping (StatusCode,UIImage)-> ()){
//       
//         let url = URL(string: urlstr)!
//    
//        URLSession.shared.dataTask(with: url, completionHandler:{
//            data,response, error in
//            guard
//                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
//                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
//                let data = data, error == nil,
//                let image = UIImage(data: data)
//            else{return}
//            
//            handler(StatusCode.complete, image)
//        } ).resume()
//        
//        }
//    
//}
 
    

extension UIImageView {
    func downloaded(from urlstr: String, contentMode mode: ContentMode = .scaleAspectFill){
        let url = URL(string: urlstr)!
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
                
                
            }
        }.resume()
        
    }
//    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
//        guard let url = URL(string: link) else { return }
//        downloaded(from: url, contentMode: mode)
//    }
}
