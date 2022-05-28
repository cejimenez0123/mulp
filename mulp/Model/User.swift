//
//  User.swift
//  mulp
//
//  Created by Christian Jimenez on 6/25/21.
//

import Foundation
import UIKit
import SwiftyJSON


class User:Hashable {
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name && lhs.email == rhs.email && lhs.username == rhs.username && lhs.profilePic == rhs.profilePic
    }
    
    var id:String = ""
    var name: String = ""
    var email:String=""
    var username:String=""
    var profilePic:String = "https://data.puzzle-markt.de/trefl.82/romantic-paris-jigsaw-puzzle-500-pieces.74942-1.fs.jpg"
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
        hasher.combine(email)
        hasher.combine(username)
        hasher.combine(profilePic)
    }
    init(id:String,email:String,username:String,name:String) {
        self.id = id
        self.email = email
        self.username = username
        self.name = name
      
    }
}
