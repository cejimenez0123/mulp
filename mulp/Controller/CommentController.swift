//
//  CommentController.swift
//  mulp
//
//  Created by Christian Jimenez on 12/12/21.
//

import UIKit

class CommentController: UIViewController {
    @IBOutlet weak var CommentSection: UITableView!
    var page:Page = Page(id: "0", path: "https://www.planetware.com/wpimages/2020/02/france-in-pictures-beautiful-places-to-photograph-eiffel-tower.jpg", type: "image")
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if (self.page.type == "image"){
            
                let imageView = UIImageView()
            imageView.downloaded(from: self.page.path)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(imageView)
            NSLayoutConstraint.activate([imageView.topAnchor.constraint(equalTo: self.view.topAnchor),imageView.leftAnchor.constraint(equalTo: self.view.leftAnchor),imageView.rightAnchor.constraint(equalTo: self.view.rightAnchor),imageView.bottomAnchor.constraint(equalTo: CommentSection.topAnchor)])
        }
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


