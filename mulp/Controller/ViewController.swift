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
    init(pages: [Page]){
        self.pages = pages
        self.pages.insert(Page(id: "1", canvas: UIImage(named: "TheNerves" )!), at: 0)
       
        super.init( style: UITableView.Style.plain)
        
       
    }
    @IBAction func uploadPhoto(_ sender: Any) {
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        present(imagePicker,animated: true)
    }
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            let page = Page(id: UUID().uuidString, canvas: image)
            pages.insert(page, at: 0)
            }

            self.imagePicker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            dismiss(animated: true)
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


