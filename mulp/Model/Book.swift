//
//  Book.swift
//  mulp
//
//  Created by Christian Jimenez on 4/17/22.
//

import Foundation
class Book{
    var id:String
    var title:String = ""
    var user:User = globalVars.currentUser
    var pages = [Page]()
    init(id:String,title:String,user:User){

        self.id = id
        self.title = title
        self.user = user
    }
    
}
