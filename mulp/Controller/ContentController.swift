//
//  ContentController.swift
//  mulp
//
//  Created by Christian Jimenez on 3/2/22.
//

import Foundation
import UIKit
//
//UITableViewDataSource, UITableViewDelegate
class ContentController: UIViewController {
    let pageClient = PageClient()
    
    @IBOutlet weak var contentView: UIImageView!
    var page = Page(id: "", path: "", type: "")
    var comments = [Comment]()
    var tableView = UITableView()
    var commController = CommentController()
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return comments.count
//    }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
//        DispatchQueue.main.async {
//
//            self.tableView.register(CommentTableViewCell.self, forCellReuseIdentifier: "CommentTableViewCell")
//        }
        commController =  self.storyboard?.instantiateViewController(withIdentifier: "CommentController") as! CommentController
        commController.page = self.page
        commController.comments = self.comments
      
        self.addChild(commController)
        let aH =  UIScreen.main.bounds.height - contentView.frame.height
        self.view.addSubview(commController.view)
        
        commController.view.frame = CGRect(x: 0, y: contentView.frame.maxY, width: UIScreen.main.bounds.width, height: aH)
        commController.didMove(toParent: self.navigationController)
        
        var items  = [UIBarButtonItem]()
        let btn = UIBarButtonItem(title: "Comment", style: .plain, target: self, action: #selector(addComment))
        items.append(btn)
        self.tabBarController?.tabBar.isHidden = false
        self.tabBarController?.toolbarItems = items
//  self.navigationController?.toolbar.isHidden = false
//  self.navigationController?.toolbar.items = items


}
@objc func addComment(){
  
}
    func setControllerData(page: Page,commentsArr: [Comment]){

        self.comments = commentsArr
        commController.comments = commentsArr

        contentView.downloaded(from: page.path)


//        tableView.reloadData()

    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 70
//    }

}
