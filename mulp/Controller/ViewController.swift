//
//  ViewController.swift
//  mulp
//
//  Created by /fam on 12/18/20.
//

import UIKit
import SwiftyJSON

class MainViewController: UITableViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var pages = [Page]()
    init(pages: [Page]){
        self.pages = pages
        
        self.pages.append(Page(id: "1", pic:UIImage(named:"TheNerves"), path: ""))
        
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
        let image = info[.originalImage] as? UIImage
        
        
        
        let page = router.uploadPage(image: image!, userId: globalVars.currentUser.id, bookId: "0")
        
            self.pages.insert(page, at: 0)
        
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
            
            
        pageCell.picture = pages[indexPath.row].pic
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

extension UIViewController{
    
//    func uploadPage(image:UIImage)-> Page{
//
//        var page:Page = Page(id: "0", path:"0")
//        guard let url = URL(string: "\(globalVars.path)/pages") else {return page; }
//        var request = URLRequest(url: url)
//        let boundary = UUID().uuidString
//        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
////            request.addValue("application/json", forHTTPHeaderField: "Accept")
//        request.httpMethod = "POST"
////        let jpegData = image.jpegData(compressionQuality: 1)
//        let parameter:NSDictionary = [
//            "image": image.pngData()!
//
//        ]
//
//        request.httpBody = try? NSKeyedArchiver.archivedData(withRootObject: parameter, requiringSecureCoding: true)
//        print("!")
//        URLSession.shared.dataTask(with: request) {(data,response,error) -> Void in
//            if let data = data, error == nil {
//
//            let json = JSON(data)
//
//                let url = URL(string:"http://www.apple.com/euro/ios/ios8/a/generic/images/og.png")
//                    if let imgData = try? Data(contentsOf: url!)
//                    {
//                        let image: UIImage = UIImage(data: imgData) ?? UIImage(named: "TheNerves")!
//                        page = Page(id: json["id"].stringValue, pic: image)
//                    }
//
//            if error != nil{ print(json.error?.rawValue ?? "No Error")}
//
//            } else {
//                print(error?.localizedDescription ?? "No data")
//                return
//            }
//
//
//        }.resume()
//        return page
//    }
    
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
