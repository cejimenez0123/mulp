//
//  ViewController.swift
//  mulp
//
//  Created by /fam on 12/18/20.
//

import UIKit
import Combine

class MainViewController: UITableViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var pages = [Page]()
    init(pages: [Page]){
        self.pages = pages
     let  page = Page(id: "1", path: "https://mulp.s3.amazonaws.com/mulp/image/image/34/RackMultipart20211107-94842-3wx0jk.jpg")
        page.pic = UIImage(named:"TheNerves")!
        
        
        self.pages.append(page)
     
            
            
           
            
        
        super.init( style: UITableView.Style.plain)
  
       
      
    }
    override func viewDidLoad() {
        self.tableView.register(PageTableViewCell.self, forCellReuseIdentifier: "PageTableViewCell")
      
        router.getAllPages(handler:{ status,pages in
            
            
            print(pages)
           
            
        })
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

    

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            dismiss(animated: true)
        }
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pages.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let pageCell = tableView.dequeueReusableCell(withIdentifier: "PageTableViewCell",for: indexPath) as! PageTableViewCell
            
       let page  = pages[indexPath.row]
        
        pageCell.pic.downloaded(from: page.path)
        pageCell.parentController = self
        return pageCell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let image = pages[indexPath.row]
        
        let crop = image.pic.widthRatio()
        return tableView.frame.width / crop + 55
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
extension MainViewController{
   func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
       let image = info[.originalImage] as? UIImage
    
    router.uploadImage(fileName: "Image", image: image, handler: { status,path  in
        router.uploadPage(userId: globalVars.currentUser.id, bookId: "0", status:"published", path: path, handler: {status,page in
                self.pages.insert(page,at:0)
            })
        
    })

    
    
   
           picker.dismiss(animated: true, completion: nil)
       tableView.reloadData()


   }

//extension UIViewController{
//    private func createBody(with parameters: [String: String]?,file:UIImage filePathKey: String, urls: [URL], boundary: String) throws -> Data {
//        )
//
//
//
//        }
//
//        body.append("--\(boundary)--\r\n")
//        return body
//    }
//}

}
extension UIImage {
    var jpeg: Data? { jpegData(compressionQuality: 1) }  // QUALITY min = 0 / max = 1
    var png: Data? { pngData() }
}
extension UIImageView{
    func load(url: URL) {
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.image = image
//                        self?.image = image
                    }
                }
            }
        }
    }
}
