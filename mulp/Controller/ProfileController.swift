//
//  ProfileController.swift
//  mulp
//
//  Created by Christian Jimenez on 7/19/21.
//

import UIKit

class ProfileController:UIViewController{
    
    var pages = [Page]()
//    @IBOutlet weak var collectionView: UICollectionView!
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 1
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        let cell  =  self.collectionView.dequeueReusableCell(withReuseIdentifier: "CollectonViewCell", for: indexPath) as! CollectionViewCell
//
//
//
//        return cell
//
//}
    
//
    
    @IBOutlet weak var LitSegmentedControl: UISegmentedControl!

    @IBOutlet weak var addButton: UIButton!
    var user = User(id: "0", email: "0", username: "0",name:"0")
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var ProfilePic: UIImageView!
    @IBOutlet weak var PageTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        NameLabel.text = self.user.username
        ProfilePic.downloaded(from: self.user.profilePic)
        ProfilePic.clipsToBounds = true
        ProfilePic.sizeThatFits(CGSize(width: 100, height: 100))
        addButton.addTarget(self, action: #selector(showCreatingView), for: .touchUpInside)
    }
    @objc func showCreatingView(){
        
        
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
