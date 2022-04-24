//
//  BookMakerTableCell.swift
//  mulp
//
//  Created by Christian Jimenez on 4/23/22.
//

import Foundation
import UIKit

class BookMakerTableCell: UITableViewCell{
    var book:Book = Book(id: "", title: "", user: globalVars.currentUser)
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var button: UIButton!
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    func setCellData(book:Book){
        titleLabel.text = book.title
        self.book = book
        
    }
    
}
