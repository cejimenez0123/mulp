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
    func uploadPage(userId:String,bookId:String,type:String, published:Bool,privacy:Bool,path:String, handler: @escaping (StatusCode,Page)->()){
        let page = Page(id: "0",path: path,type: type)
        guard let url = URL(string: "\(globalVars.path)/pages") else {
            return
        }
        let session = URLSession.shared
         var request = URLRequest(url: url)
        let param:NSDictionary = ["data": path, "userId": userId,"bookId":bookId,"status":published,"privacy":privacy,"type":type]
        request.httpMethod = "POST"
        let body = try! JSONSerialization.data(withJSONObject:param, options: .prettyPrinted)
        request.httpBody = body
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        session.dataTask(with: request){(data, response, error) in
            
            if error != nil {
                print(error!)
            }
            guard let data = data else {return}
           let json = JSON(data)
           let atr = json["data"]["attributes"]
            
            page.id = json["data"]["id"].stringValue
            page.path = atr["data"].stringValue
            let user =  User(id:atr["user"]["id"].stringValue,email: atr["user"]["email"].stringValue, username: atr["user"]["username"].stringValue, name: atr["user"]["name"].stringValue)
            page.user.id = user.id
            page.user = user
            handler(StatusCode.complete,page)
        }.resume()

        }
    func getAllPages(handler:@escaping (StatusCode, [Page])->()){
        guard let url = URL(string: "\(globalVars.path)/pages") else { return }
       let request = URLRequest(url: url)
        let session = URLSession.shared
        
        session.dataTask(with: request){(data,resp,err) in
            
            
            if err != nil {
                print(err! as Error)
            }else {
                let json = JSON(data!)
                let  ps = json["data"].arrayValue
                
                    if ps.count > 0 {
                        let pages =   ps.map { pdata -> Page in
                            let attr = pdata["attributes"]
                        
                            let user = User(id: attr["user"]["id"].stringValue,
                            email: attr["user"]["email"].stringValue, username: attr["user"]["username"].stringValue, name: attr["user"]["name"].stringValue)
                            
                            let id = attr["id"].stringValue
                            let path = attr["data"].stringValue
                            let type = attr["media"].stringValue
                            let page = Page(id: id, path: path,type:type)
                            page.published = attr["published"].rawValue as! Bool
                            page.user = user
                            return page
            }
            
            handler(StatusCode.complete, pages )
        }}
            
        }.resume()
        
        
    }
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
