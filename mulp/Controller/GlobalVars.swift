//
//  GlobalValues.swift
//  mulp
//
//  Created by Christian Jimenez on 7/6/21.
//

import Foundation
import UIKit
import SwiftyJSON
//

class GlobalVars{
    var userLoggedIn = false
    var path="http://127.0.0.1:3000"
    var currentUser:User = User(id: "0", email: "0@0.com", username: "0")
    
}
let globalVars = GlobalVars()


class Router {
    func uploadImage(fileName:String,image: UIImage)->String{
        let boundary = UUID().uuidString
        var path = "NO PATH"
        guard let url = URL(string: "\(globalVars.path)/image/upload") else {return  path}

            let session = URLSession.shared
        let paramName = "file"
            // Set the URLRequest to POST and to the specified URL
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "POST"
        var userId = globalVars.currentUser.id
            // Set Content-Type Header to multipart/form-data, this is equivalent to submitting form data with file upload in a web browser
            // And the boundary is also set here
            urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

            var data = Data()

            // Add the image data to the raw http request data
            data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
            data.append("Content-Disposition: form-data; name=\"\(paramName)\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
            data.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
            data.append(image.pngData()!)
//        data.append("name=\"userId\";".data(using: .utf8)!)
//        data.append("\(user.id)".data(using: .utf8)!)
//        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
    
                    // Send a POST request to the URL, with the data we created earlier
            session.uploadTask(with: urlRequest, from: data, completionHandler: { responseData, response, error in
                if error == nil {
                    print(error!)
                }
                let json = JSON(data)
                                
                let url = json["data"]["attributes"]["path"].string
                path = url ?? "NO PATH"
                        }
                ).resume()
                        
                        
                        
        return path
    }
    func uploadPage(path:String, userId:String,bookId:String )->Page{
        let page = Page(id: "0", pic: UIImage(named: "TheNerves")!)
        guard let url = URL(string: "\(globalVars.path)/pages") else {
            return page
        }
        let session = URLSession.shared
        
         var request = URLRequest(url: url)
        let param:NSDictionary = ["data": path, "userId": userId,"bookId":bookId]
        request.httpMethod = "POST"
        let body = try! JSONSerialization.data(withJSONObject:param, options: .prettyPrinted)
        request.httpBody = body
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        session.dataTask(with: request){(data, response, error) in
            
           
           let json = JSON(data)
            
            if error != nil {
                print(error!)
            }
            page.id = json["data"]["attributes"]["id"].stringValue
            page.path = json["data"]["attributes"]["data"].stringValue
    }
     
    
    
        return page
    }
}
let router = Router()
//extension Dictionary {
//    func percentEncoded() -> Data? {
//        return map { key, value in
//            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
//            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
//            return escapedKey + "=" + escapedValue
//        }
//        .joined(separator: "&")
//        .data(using: .utf8)
//    }
//}
