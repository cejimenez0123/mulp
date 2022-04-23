//
//  ViewController.swift
//  mulp
//
//  Created by /fam on 12/18/20.
//

import UIKit
import Combine

class MainViewController: UITableViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let miscClient = MiscClient()
    let pageClient = PageClient()
    var pages = [Page]()
    init(pages: [Page]){
        super.init( style: UITableView.Style.plain)
        self.pages  = pages
           
      
      
    }
    override func viewDidLoad() {
        self.tableView.register(PageTableViewCell.self, forCellReuseIdentifier: "Page/Users/cejim/Development/mulp/mulp/Controller/LogInController.swiftTableViewCell")
        pageClient.getAllPages(handler:{ [self] status,ps in
          
            
            
            self.pages.append(contentsOf: ps)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
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


    @IBAction func logInSegue(_ sender: Any) {
        let sccon = self.storyboard?.instantiateViewController(withIdentifier: "SignUpController") as! SignUpController
           self.navigationController?.present(sccon, animated: true, completion: {
               return
           })
    }
    @objc func logInSegue(){
        
     let logInCon = self.storyboard?.instantiateViewController(withIdentifier: "LogInController") as! LogInController
        self.navigationController?.pushViewController(logInCon, animated: true)
        
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
        pageCell.page = page
        pageCell.pic.downloaded(from: page.path)
        pageCell.parentController = self
        return pageCell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let image = pages[indexPath.row]
//        tableView.frame.width
        let crop = image.pic.heightRatio()
        return tableView.frame.width / crop
    }
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//
//  let image = pages[indexPath.row]
////        let crop = image.pic.widthRatio()
////        tableView.frame.width / crop + 55
//       let x = image.pic.heightRatio()
//        return tableView.frame.width /  x + 55
//
//    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return pages.count
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
     
        miscClient.uploadImage(fileName: "Image", image: image, handler: { status,path  in
            
            pageClient.uploadPage(userId: globalVars.currentUser.id, bookId: "0", type:"image", status:"published", path: path, handler: {status,page in
                 self.pages.insert(page,at:0)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
             })
         
     })

     
     
    
            picker.dismiss(animated: true, completion: nil)
        


    }
        
}
extension UIImage{
    
    func widthRatio() -> CGFloat {
        return  CGFloat(self.size.width / self.size.height)
        
    }
    func heightRatio()-> CGFloat{
        return CGFloat(self.size.height / self.size.width)
    }
    func adjustExposure(byVal: CGFloat) -> UIImage {
        let ciimage = CIImage.init(cgImage: self.cgImage ?? self as! CGImage)
        let filter = CIFilter.init(name: "CIExposureAdjust")
        filter?.setValue(ciimage, forKey: kCIInputImageKey)
       
        filter?.setValue(byVal, forKey: kCIInputEVKey)
        let result = filter?.value(forKey: kCIOutputImageKey) as! CIImage
        let cgimage = CIContext.init(options: nil).createCGImage(result, from: result.extent)
        let image = UIImage.init(cgImage: cgimage!)
            return image
        }


}
extension MainViewController{
    
 

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
