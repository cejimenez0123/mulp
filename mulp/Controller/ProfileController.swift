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
//
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var ProfilePic: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        ProfilePic.layer.cornerRadius = ProfilePic.layer.borderWidth / 5
//        NSLayoutConstraint.activate([ProfilePic.widthAnchor.constraint(equalToConstant:  100),ProfilePic.heightAnchor.constraint(equalToConstant: 100), ProfilePic.centerXAnchor.constraint(equalTo: self.view.centerXAnchor), ProfilePic.centerYAnchor.constraint(equalTo: self.view.topAnchor,constant: 100)])
        
    
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
