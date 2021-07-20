//
//  GlobalValues.swift
//  mulp
//
//  Created by Christian Jimenez on 7/6/21.
//

import Foundation
import UIKit
//

class GlobalVars{
    var userLoggedIn = false
    var path="http://127.0.0.1:3000"
}
let globalVars = GlobalVars()

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
