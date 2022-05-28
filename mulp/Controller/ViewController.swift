//
//  ViewController.swift
//  mulp
//
//  Created by /fam on 12/18/20.
//

import UIKit
import Combine
import SDWebImage
class MainViewController: UITableViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    let miscClient = MiscClient()
    let pageClient = PageClient()
    var pages = [Page]()

    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageClient.getAllPages(handler:{ [self] status,ps in
   
            self.pages.append(contentsOf: ps)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        })
        self.tableView.estimatedRowHeight = UITableView.automaticDimension
        self.tableView.rowHeight = 200
        let nib = UINib(nibName: "PageTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "PageTableViewCell")
    }
    
    
    @IBAction func uploadPhoto(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        present(imagePicker,animated: true)
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
       
        
        let pageCell =  self.tableView.dequeueReusableCell(withIdentifier: "PageTableViewCell", for: indexPath) as! PageTableViewCell
       let page  = pages[indexPath.row]
 
        pageCell.setCellData(page: page)
        pageCell.parentController = self
        
      
        return pageCell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if ((self.tableView.cellForRow(at: indexPath)) == nil) {
            return 200
        }else{
           let cell = self.tableView.cellForRow(at: indexPath) as! PageTableViewCell
                
            return cell.cellHeight
            
        }
    }
   
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell =  tableView.cellForRow(at: indexPath) as! PageTableViewCell
        cell.setCellHeight()
        tableView.beginUpdates()
        
        
        
        tableView.endUpdates()

    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
     
        miscClient.uploadImage(fileName: "Image", image: image, handler: { status,path  in
            
            self.pageClient.uploadPage(userId: globalVars.currentUser.id, bookId: "0", type:"image", published: true,privacy: false, path: path, handler: {status,page in
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
