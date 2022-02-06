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
import Combine
enum StatusCode {
    case startup
    case busy
    case complete
}
class GlobalVars{
    var userLoggedIn = false
    var path="http://127.0.0.1:3000"
    var currentUser:User = User(id: "0", email: "0@0.com", username: "0")
    
}
let globalVars = GlobalVars()
let router = Router()

class Router {
    func uploadPage(userId:String,bookId:String,type:String, status:String,path:String, handler: @escaping (StatusCode,Page)->()){
        let page = Page(id: "0",path: path,type: type)
        guard let url = URL(string: "\(globalVars.path)/pages") else {
            return
        }
        let session = URLSession.shared
         var request = URLRequest(url: url)
        let param:NSDictionary = ["data": path, "userId": userId,"bookId":bookId,"status":status,"type":type]
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
            let user =  User(id:atr["user"]["id"].stringValue,email: atr["user"]["email"].stringValue, username: atr["user"]["username"].stringValue)
            user.name = atr["user"]["name"].stringValue
            page.userId = user.id
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
                            
                            let id = attr["id"].stringValue
                            let path = attr["data"].stringValue
                            let type = attr["media"].stringValue
                            return Page(id: id, path: path,type:type)
            }
            
            handler(StatusCode.complete, pages )
        }}
            
        }.resume()
        
        
    }
    func uploadImage(fileName:String,image: UIImage?,handler:@escaping ((StatusCode,String)->())){

        
      
        if let image = image {                  
        let boundary = UUID().uuidString
        guard let url = URL(string: "\(globalVars.path)/image/upload") else {return }
            let session = URLSession.shared
            let jpegRep = image.jpegData(compressionQuality:1)
//            let base64Image = jpegRep!.base64EncodedData()
            if jpegRep == nil {return}
//            let boundary = UUID().uuidString
            let param = ["username": globalVars.currentUser.username]
//            let url = URL(string: "\(globalVars.path)/image/upload")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            request.httpBody = createBodyWithParameters(parameters: param, filePathKey: "file", imageDataKey:jpegRep!, boundary: boundary, imgKey: "Attempt") as Data
           
            session.dataTask(with: request, completionHandler: { data, response, error in
                if error == nil {
                    print(error ?? "NO ERROR")
                }
                guard let data = data else { return }
                let json = JSON(data)
            
                   
                    let path = json["link"].stringValue
                           handler(StatusCode.complete,path)
                
                
               
            }).resume()
            
        
                  
        }
    }}
       
    
    func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, imageDataKey: Data, boundary: String, imgKey: String) -> Data {
        var body = Data()

            if parameters != nil {
                for (key, value) in parameters! {
                    body.append("--\(boundary)\r\n".data(using: .utf8)!)
                    body.append( "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
                    body.append( "\(value)\r\n".data(using: .utf8)!)
                }
            }

            let filename = "\(imgKey).jpg"
            let mimetype = "image/jpg"

        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: \(mimetype)\r\n\r\n".data(using: .utf8)!)
            body.append(imageDataKey as Data)
        body.append("\r\n".data(using: .utf8)!)
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)

            return body
        }


   
    func signUp(username:String,email:String,password:String){
        
        guard let url = URL(string: "\(globalVars.path)/users") else {return}
         var request = URLRequest(url: url)
 //
         request.addValue("application/json", forHTTPHeaderField: "Content-Type")
             request.addValue("application/json", forHTTPHeaderField: "Accept")
         request.httpMethod = "POST"
         let parameters:NSDictionary = [
             "id": "\(UUID())",
             "username": username,
             "email": email,
             "password": password
         ]
        do {
               request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
           } catch let error {
               print(error.localizedDescription)
           }

             request.timeoutInterval = 10
 //
 //
         URLSession.shared.dataTask(with: request) {(data,response,error) -> Void in
 //                print("@")
             if let data = data, error == nil {
 //
             let json = JSON(data)
             if error != nil{ print(json.error?.rawValue ?? "No Error")}
                 let att = json["data"]["attributes"]["username"]
                 print(json["data"]["attributes"])
                 globalVars.currentUser =  User(id: att["id"].stringValue, email: att["email"].stringValue, username: att["username"].stringValue)
                 
    }
    
    
    }

    }
