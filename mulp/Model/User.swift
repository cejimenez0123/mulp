//
//  User.swift
//  mulp
//
//  Created by Christian Jimenez on 6/25/21.
//

import Foundation
import UIKit


class User {
    var id:String = ""
    var name: String = ""
    var email:String=""
    var username:String=""
    init(id:String,email:String,username:String) {
        self.id = id
        self.email = email
        self.username = username
      
    }
}
