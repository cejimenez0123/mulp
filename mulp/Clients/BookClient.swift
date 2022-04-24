//
//  BookClient.swift
//  mulp
//
//  Created by Christian Jimenez on 4/19/22.
//

import Foundation
import SwiftyJSON

class BookClient{
    let path = globalVars.path
    
    func getBooksOfUser(user_id:String, handler: @escaping (([Book])->Void)){
        let url = URL(string: "\(path)/users/\(user_id)/books")!
        var request = URLRequest(url: url)
    
        request.httpMethod = "GET"
        
       
        URLSession.shared.dataTask(with: request, completionHandler: {data,resp,err in
            var books = [Book]()
            if let dat = data{
                do{
                let json = try JSON(data: dat)
                    let bookArr = json["data"]
                    for (_,b) in bookArr{
                      let attr = b["attributes"]
                        let user = User(id: "", email: "", username: "", name: "")
                        user.id = attr["user"]["id"].stringValue
                        user.email = attr["user"]["email"].stringValue
                        user.username = attr["user"]["username"].stringValue
                        user.name = attr["user"]["name"].stringValue
                        let book = Book(id: attr["id"].stringValue, title: attr["title"].stringValue, user: user)
                        
                        books.append(book)
                    }
                    handler(books)
                } catch let error{
                    print(error.localizedDescription)
                }
                
            }
        }).resume()
      
        
    }
    func createBook(user:User,title: String,pages: [Page]){
        
        let url = URL(string: "\(path)/books")!
        var request = URLRequest(url: url)
        var params:NSDictionary
        if pages.count > 0{
            params = [user:user,title: title,pages:pages]
            
        }
        else{
            params = [user: user]
            }
        request.httpMethod = "POST"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
        do {
        request.httpBody =  try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
            } catch let error {
                print(error.localizedDescription)
            }
        
        URLSession.shared.dataTask(with: request, completionHandler: {data,resp,err in
            if let dat = data {
            do{
                let json = try JSON(data: dat)
                
            } catch let error{
                print(error.localizedDescription)
                
            }}
            
        }).resume()
    }
}
