//
//  BookClient.swift
//  mulp
//
//  Created by Christian Jimenez on 4/19/22.
//

import Foundation


class BookClient{
    let path = globalVars.path
    
    func getBooksOfUser(user_id:String){
        let url = URL(string: "\(path)/users/\(user_id)/books")!
        var request = URLRequest(url: url)
    
        request.httpMethod = "GET"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
       
        
        URLSession.shared.dataTask(with: request, completionHandler: {data,resp,err in
            
            
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
            
            
        }).resume()
    }
}
