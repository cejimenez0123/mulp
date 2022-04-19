//
//  PageClient.swift
//  mulp
//
//  Created by Christian Jimenez on 4/19/22.
//

import Foundation
import SwiftyJSON
class PageClient{
    let path = globalVars.path
    
    func getPagesOfUser(id: String, handler: @escaping (([Page])->Void)){
        
        let url  = URL(string:"\(path)/users/\(id)/pages")!
        var request = URLRequest(url: url)
        
        
        request.httpMethod = "GET"
        
        
        URLSession.shared.dataTask(with: request, completionHandler: {
            data,resp,err in
            var pages = [Page]()
            if data != nil {
            let json = JSON(data!)
                
               for ( _,pagej) in json["data"] {
                let att =  pagej["attributes"]
                
                   
                   
                   var page = Page(id: att["id"].stringValue, path: att["data"].stringValue, type: "")
                   let user  = att["user"]
                  let u =  User(id: user["id"].stringValue, email: user["email"].stringValue, username: user["username"].stringValue, name: user["name"].stringValue)
                   page.user = u
                   
                   pages.append(page)
                }
                 
                
                handler(pages)
            }else{
                
                print(err!.localizedDescription)
            }
            
        }).resume()
        
    }
}
