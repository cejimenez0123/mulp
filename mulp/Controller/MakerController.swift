//
//  BookMakerController.swift
//  mulp
//
//  Created by Christian Jimenez on 4/17/22.
//

import Foundation
import UIKit


class MakerController:UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    var imagePicker = UIImagePickerController()
    var user = globalVars.currentUser
    var pages = [Page]()
    var books = [Book]()
    let pageClient = PageClient()
    let miscClient = MiscClient()
    @IBOutlet weak var pageButton: UIButton!
    @IBOutlet weak var bookButton: UIButton!
    @IBOutlet weak var libraryButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        pageButton.addTarget(self, action: #selector(showPageMaker), for: .touchUpInside)
        bookButton.addTarget(self, action: #selector(showBookMaker), for: .touchUpInside)
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            dismiss(animated: true)
        }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        picker.dismiss(animated: true, completion: nil)
        let pag = Page(id: "", path: "", type: "")
        pag.pic = image ?? UIImage(named: "TheNerves")!
    let ac = UIAlertController(title: "Add Name for Page", message: "Please add a name ", preferredStyle: .alert)
        ac.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Page Name"
            
        }
        let act = UIAlertAction(title: "Save", style: .default, handler: { [self] _ in
            pag.name = ac.textFields?[0].text ?? ""
    
            self.pageClient.uploadPage(userId: user.id, bookId: "", type: "page", status: "published", path: "", handler: { stat,page in
                
                
                
                
            })
        })
        ac.addAction(act)
        present(ac, animated: true, completion: {})
    }
    @objc func showPageMaker(){
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        present(imagePicker,animated: true)
    }
    @objc func showBookMaker(){
     
        DispatchQueue.main.async {
            let bmCon = self.storyboard?.instantiateViewController(withIdentifier: "BookMakerController") as! BookMakerController
            print("@+#%#")
            bmCon.pages = self.pages
            self.navigationController?.show(bmCon, sender: self)
       
        }
    }
    @objc func showLibraryMaker(){}
    
}

