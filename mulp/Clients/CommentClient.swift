//
//  PageClient.swift
//  mulp
//
//  Created by Christian Jimenez on 3/27/22.
//

import Foundation

import SwiftyJSON


class CommentClient{
    let path="http://127.0.0.1:3000"
    
    func getCommentsOfPage(page_id: String,handler:  @escaping ([Comment])->Void){
        var comments = [Comment]()
        
        let url = URL(string: "\(path)/pages/\(page_id)/page_comments")
        
        var request  = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request, completionHandler: {data,resp,err in
            
            
            
            if data != nil {
            let json = JSON(data!)
                
                for (_,value) in json["data"]{
                    let comment =  Comment()
                    comment.id = value["id"].stringValue
                    comment.user.id = value["attributes"]["user"]["id"].stringValue
                    comment.user.username = value["attributes"]["user"]["username"].stringValue
                    comment.user.email = value["attributes"]["user"]["email"].stringValue
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
    func postComment(text:String,page_id:String,user_id:String,handler: @escaping (Comment)->()){
        
        
        let url = URL(string: "\(path)/page_comments")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let parameters:NSDictionary = ["text": text, "user_id": user_id, "page_id": page_id]
        do{
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody =  try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
    
            
            URLSession.shared.dataTask(with: request, completionHandler: {data,resp,err in
                do {
                
                let json =  try JSON(data:data!)
                    let attr = json["data"]
                    let com = Comment()
                    com.id = attr["id"].stringValue
                   let userj = attr["attributes"]["user"]
                    let user = User(id: userj["id"].stringValue, email: userj["email"].stringValue, username: userj["username"].stringValue)
                    com.user = user
                    com.text = attr["attributes"]["text"].stringValue
                    handler(com)
                } catch let error {
                    print(error.localizedDescription)
                }
                    
                guard err == nil else {return }
                
                
                
                
            }).resume()
        } catch let error {
    print(error.localizedDescription)
}

    }
    
}


