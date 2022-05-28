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
    var selectedPages = [Page]()
    let bookClient = BookClient()
    @IBOutlet weak var titleLabel: UILabel!
//    weak var button: UIButton!
    @IBAction func addPagesToBook(_ sender: Any) {
        bookClient.addPagesToBook(pages: selectedPages, book_id: book.id, handler: {
            status in
            if (status == StatusCode.complete) {
           let ac = UIAlertController(title: "Book Added", message: "Book Added", preferredStyle: .alert)
           let act = UIAlertAction(title: "OK", style: .default, handler: {_ in
                ac.dismiss(animated: true, completion: nil)
           })
                ac.addAction(act)}
        })
    }
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
