//
//  ViewController.swift
//  mulp
//
//  Created by /fam on 12/18/20.
//

import UIKit


class MainViewController: UITableViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var pages = [Page]()
    init(pages: [Page]){
        self.pages = pages
        self.pages.append(Page(id: "1", canvas: UIImage(named: "TheNerves" )!))
        
        super.init( style: UITableView.Style.plain)
        
    
       
      
    }
    override func viewDidLoad() {
        self.tableView.register(PageTableViewCell.self, forCellReuseIdentifier: "PageTableViewCell")
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.estimatedRowHeight = UITableView.automaticDimension
        self.tableView.rowHeight = 100
    }
    @IBAction func uploadPhoto(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        present(imagePicker,animated: true)
    }
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
       let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        let page = Page(id: UUID().uuidString, canvas: image)
        pages.insert(page, at: 0)
        
            picker.dismiss(animated: true, completion: nil)
        tableView.reloadData()
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            dismiss(animated: true)
        }
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pages.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let pageCell = tableView.dequeueReusableCell(withIdentifier: "PageTableViewCell",for: indexPath) as! PageTableViewCell
       
        pageCell.pic.image = pages[indexPath.row].picture
        

        self.tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.fade)
        
        
        
        return pageCell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let image = pages[indexPath.row]
        
        let crop = image.picture.widthRatio()
        return tableView.frame.width / crop
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return pages.count
    }
   
        
}
extension UIImage{
    
    func widthRatio() -> CGFloat {
        return  CGFloat(self.size.width / self.size.height)
        
    }
}


