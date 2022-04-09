//
//  CommentController.swift
//  mulp
//
//  Created by Christian Jimenez on 4/2/22.
//

import Foundation
import UIKit
//
class CommentController:UITableViewController, UITabBarDelegate{
    
    var page  = Page(id: "", path: "", type: "")
    var comments = [Comment]() {didSet{
        self.tableView.reloadData()
    }}
    @IBOutlet weak var tabBar: UITabBar!
    let pageClient = PageClient()
    override func viewDidLoad() {
        super.viewDidLoad()

        pageClient.getCommentsOfPage(page_id: page.id, handler: { comm in

            DispatchQueue.main.async {
                self.comments = comm
                self.tableView.reloadData()
            }
        })
        tabBar.delegate = self
        
    
//
//        let bounds = UIScreen.main.bounds
        
        
        
            

    
    }
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
       let text = UITextField()
        item.
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let nib = UINib(nibName: "CommentTableViewCell", bundle: Bundle(for: CommentTableViewCell.self))
        tableView.register(nib, forCellReuseIdentifier: "CommentTableViewCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentTableViewCell") as! CommentTableViewCell
        let comment =  self.comments[indexPath.row]
        
        cell.setCellData(comment: comment)
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func setComments(commentsArr:[Comment]){
        self.comments = commentsArr}
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cell = tableView.cellForRow(at: indexPath)
        as! CommentTableViewCell
        let fixedWidth = cell.commentView.frame.size.width - 10
        let newSize = cell.commentView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        return newSize.height + 30
    }

