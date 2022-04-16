//
//  ProfileController.swift
//  mulp
//
//  Created by Christian Jimenez on 7/19/21.
//

import UIKit

class ProfileController:UIViewController{
    
//
    
    @IBOutlet weak var LitSegmentedControl: UISegmentedControl!

    var currentUser = User(id: "0", email: "0", username: "0",name:"0")
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var ProfilePic: UIImageView!
    @IBOutlet weak var PageTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        NameLabel.text = self.currentUser.username
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    required init?(coder aDecoder: NSCoder) {
       
       super.init(coder: aDecoder)
    }
    
    @IBAction func LitIndexChanged(_ sender:UISegmentedControl) {
                switch sender.selectedSegmentIndex
                {
                case 0:
                    NSLog("Popular selected")
                    //show popular view
                case 1:
                    NSLog("History selected")
                    //show history view
                default:
                    break;
                }
            }
    
}
