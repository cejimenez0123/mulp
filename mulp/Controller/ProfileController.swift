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

    let currentUser = User(id: "0", email: "0", username: "0")
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var ProfilePic: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

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
