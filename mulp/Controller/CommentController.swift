//
//  CommentController.swift
//  mulp
//
//  Created by Christian Jimenez on 12/12/21.
//

import UIKit

class CommentController: UITableViewController {
  
    var comments = [Comment]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return comments.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let comCell = tableView.dequeueReusableCell(withIdentifier: "CommentTableViewCell",for: indexPath) as! CommentTableViewCell
       let com = comments[indexPath.row]
        comCell.comment  = com
        comCell.user = com.commenter
        return comCell
    }
        
       
override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
            super.init(nibName: nibNameOrNil, bundle:nibBundleOrNil)
       
        }
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            
            
        }
}

        
        
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


