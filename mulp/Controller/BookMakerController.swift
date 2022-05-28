//
//  BookMakerController.swift
//  mulp
//
//  Created by Christian Jimenez on 4/23/22.
//

import Foundation
import UIKit

class BookMakerController:UITableViewController{
    var footerView = UIView(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40))
    var pages = [Page]()
    var books = [Book]()
    var createButton = UIButton()
    let user:User = globalVars.currentUser
    let bookClient = BookClient()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 70
    }
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
      
    }
      
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        createButton.frame = CGRect(x: UIScreen.main.bounds.midX, y: 20, width: 100, height: 40)
        createButton.setTitle("Create new Book", for: .normal)
        createButton.addTarget(self, action: #selector(createBook), for: .touchUpInside)
        footerView.addSubview(createButton)
        
        return footerView
    }
    @objc func createBook(){
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let nib = UINib(nibName: "BookMakerTableCell", bundle: Bundle(for: BookMakerTableCell.self))
        tableView.register(nib, forCellReuseIdentifier: "BookMakerTableCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookMakerTableCell", for: indexPath) as! BookMakerTableCell
        let book = books[indexPath.row]
        cell.setCellData(book: book)
        cell.selectedPages = pages
         
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      
        
        return 80
    }
    
}
