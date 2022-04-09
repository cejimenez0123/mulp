//
//  CommentTableView.swift
//  mulp
//
//  Created by Christian Jimenez on 3/27/22.
//

//import Foundation
//import UIKit
//class CommentTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
//    var comments = [Comment]()
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return comments.count
//    }
//    
//   
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder:aDecoder)
//        self.delegate = self
//        self.dataSource = self
//    }
//    override func didMoveToSuperview() {
//        self.register(UITableViewCell.self, forCellReuseIdentifier: "CommentTableViewCell")
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let comCell = tableView.dequeueReusableCell(withIdentifier: "CommentTableViewCell",for: indexPath) as! CommentTableViewCell
//       let com = comments[indexPath.row]
//        comCell.setCellData(comment: com)
//        return comCell
//    }
//}
