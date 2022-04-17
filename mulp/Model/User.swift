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
    var profilePic:String = "https://data.puzzle-markt.de/trefl.82/romantic-paris-jigsaw-puzzle-500-pieces.74942-1.fs.jpg"
    init(id:String,email:String,username:String,name:String) {
        self.id = id
        self.email = email
        self.username = username
        self.name = name
      
    }
}
