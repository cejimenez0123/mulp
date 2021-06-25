//
//  ViewController.swift
//  mulp
//
//  Created by /fam on 12/18/20.
//

import UIKit

class PageCell:UITableViewCell{
    
}

class MainViewController: UITableViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let imagePicker = UIImagePickerController()
    var pages = [Page]()
    @IBAction func uploadPhoto(_ sender: Any) {
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        present(imagePicker,animated: true)
    }
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
    }
    init(pages: [Page]){
        self.pages = pages
        self.pages.insert(Page(id: "1", canvas: UIImage(named: "TheNerves" )!), at: 0)
       
        super.init( style: UITableView.Style.plain)
        
       
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PageTableViewCell", for: indexPath)
        
        
        return cell
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.pages.count
    }
        
}
extension UIImage{
    
    func widthRatio() -> Float {
        return  Float(self.size.height / self.size.width)
        
    }
}


