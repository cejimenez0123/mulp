//
//  ProfileController.swift
//  mulp
//
//  Created by Christian Jimenez on 7/19/21.
//

import UIKit

class ProfileController:UIViewController{
    
    
    @IBOutlet weak var LitSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var ProfilePic: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    @IBAction func LitIndexChanged(_ sender: Any) {
        UISegmentedControl) {
                switch segmentedControl.selectedSegmentIndex
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
}
//protocol SegmentedControlDelegate:AnyObject{
//    func didIndexChanged(at index: Int)
//}
//protocol TableViewDidScrollDelegate:class {
//    func TableViewDidScroll(for x: CGFloat)
//    
//}
