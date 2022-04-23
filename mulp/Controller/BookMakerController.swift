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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
}
