//
//  PageClient.swift
//  mulp
//
//  Created by Christian Jimenez on 3/27/22.
//

import Foundation

import SwiftyJSON


class PageClient{
    let path="http://127.0.0.1:3000"
    
    func getCommentsOfPage(page_id: String,handler:  @escaping ([Comment])->Void){
        var comments = [Comment]()
        
        let url = URL(string: "\(path)/pages/\(page_id)/comments")
        
        var request  = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request, completionHandler: {data,resp,err in
            
            
            
            if data != nil {
            let json = JSON(data!)
                
                for (_,value) in json["data"]{
                    let comment =  Comment()
                    comment.id = value["id"].stringValue
                    comment.user.id = value["relationships"]["user"]["data"]["id"].stringValue
                    comment.user.username = value["relationships"]["user"]["data"]["username"].stringValue
                    comment.user.email = value["relationships"]["user"]["data"]["email"].stringValue
                    comment.text = value["attributes"]["text"].stringValue
                   
                          comments.insert(comment, at: 0)
                }
                
                
                
                
      
                
            }
           handler(comments)

            guard err == nil else {
             
                
            
                return
            }
            
            
            
        }).resume()
        
    }
//    func getUsersOfComments(comments:[Comment], handler: @escaping ([User])->Void){
//
//     let url = URL(string: "\(path)/comments/users")!
//      var request =  URLRequest(url: url)
//
//        request.httpMethod = "POST"
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//            request.addValue("application/json", forHTTPHeaderField: "Accept")
//       let ids = comments.map{(comment)-> String in
//            return comment.id
//
//        }
//
//        let parameters: [String: Any] = [
//            "comment_ids": ids
//        ]
//        do {
//               request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
//           } catch let error {
//               print(error.localizedDescription)
//           }
//        var users:[User]
//        URLSession.shared.dataTask(with: request, completionHandler: {data,resp, err in
//            do{
//                print("\(data == nil)")
//            if data != nil{
//           let json = try JSON(data: data!)
//
//            }
//            }catch{
//                if err != nil {
//
//                     print(err!)
//                 }
//            }
//
//        }).resume()
//    }
}


