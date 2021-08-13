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
            urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            var data = Data()
        guard let imageData = image.pngData() else {return "NO DATA"}
            // Add the image data to the raw http request data
            data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
            data.append("Content-Disposition: form-data; name=\"\(paramName)\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
            data.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
        data.append("\(imageData)\r\n--\(boundary)--\r\n".data(using: .utf8)!)

//        data.append("name=\"userId\";".data(using: .utf8)!)
//        data.append("\(user.id)".data(using: .utf8)!)
//        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
    
                    // Send a POST request to the URL, with the data we created earlier
            session.uploadTask(with: urlRequest, from: data, completionHandler: { data, response, error in
                if error == nil {
                    print(error ?? "NO ERROR")
                }
                guard let data = data else { return }
                let json = JSON(data)
                                
                let url = json["link"].stringValue
          
                path = url
                        }
                ).resume()
                        
                        
                        
        return path
    }
    func uploadPage(image:UIImage, userId:String,bookId:String ) async -> Page{
       let path =  self.uploadImage(fileName: "Image",image: image)
        let page = Page(id: "0", pic:UIImage(named: "TheNerves"),path: path)
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
            
            if error != nil {
                print(error!)
            }
            guard let data = data else {return}
           let json = JSON(data)
            
            
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
