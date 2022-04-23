//
//  MiscClient.swift
//  mulp
//
//  Created by Christian Jimenez on 4/23/22.
//

import Foundation
import SwiftyJSON
class MiscClient{
    
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
    }
}
