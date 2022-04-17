//
//  UserClient.swift
//  mulp
//
//  Created by Christian Jimenez on 4/17/22.
//

import Foundation
import SwiftyJSON

class UserClient{
    let path = globalVars.path
    
    func getPagesOfUser(id: String){
        
        let url  = URL(string:"\(path)/users/\(id)/pages")!
        var request = URLRequest(url: url)
        
        
        request.httpMethod = "GET"
        
        
        URLSession.shared.dataTask(with: request, completionHandler: {
            data,resp,err in
            
            
            
        })
        
    }
    func getBooksOfUser(id: String){
        
        
        
    }
}
