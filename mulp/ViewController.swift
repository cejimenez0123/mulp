//
//  ViewController.swift
//  mulp
//
//  Created by /fam on 12/18/20.
//

import UIKit

class PageCell:UITableViewCell{
    
}

class MainViewController: UITableViewController {
    var pages = [Page]()
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
    }
    init(pages: [Page]){
        self.pages = pages
        self.pages.insert(Page(id: "1", canvas: UIImage(named: "TheNerves" )!), at: 0)
       
        super.init( style: UITableView.Style.plain)
        
       
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.pages.count
    }
        
}
extension UIImage{
    
    func widthRatio() -> Float {
        return  Float(self.size.height / self.size.width)
        
    }
}


