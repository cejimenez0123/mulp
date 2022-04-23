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
            miscClient.uploadImage(fileName: pag.name, image: image, handler: {code, path in
                
                self.pageClient.uploadPage(userId: user.id, bookId: "", type: "page", published: true,privacy: false, path: path, handler: { stat,page in
            
                if let navCont = self.navigationController {
                    let comCon = CommentController()
                    let mainCon = MainViewController(pages: [])
                    var stack = navCont.viewControllers
                    comCon.page = page
                    DispatchQueue.main.async {
                    
                    stack.remove(at: stack.count - 1)
                    stack.insert(mainCon, at: stack.count - 1)
                    stack.insert(comCon, at: stack.count)
                    navCont.setViewControllers(stack, animated: true)
                        
                    }
                }
                
                
            })})
        })
        ac.addAction(act)
        present(ac, animated: true, completion: {})
    }
    @objc func showPageMaker(){
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        let ac = UIAlertController(title: "Would you like to?", message: "Upload image or use link", preferredStyle: .alert)
    
        let act1 = UIAlertAction(title: "Upload", style: .default, handler: { [self] _ in
            self.present(self.imagePicker,animated: true)
        })
        let act2 = UIAlertAction(title: "Link", style: .default, handler: {[self] _ in
            ac.dismiss(animated: true, completion: {
        let ac2 = UIAlertController(title: "Add Link", message: "", preferredStyle: .alert)
            ac2.addTextField(configurationHandler:{_ in })
            let act21 = UIAlertAction(title: "Save", style: .default, handler: { _ in
                //Save Link
                ac2.dismiss(animated: true, completion: {
                let p = Page(id:"",path: ac.textFields?[0].text ?? "", type:"Link")
                pageClient.uploadPage(userId: user.id, bookId: "", type: p.type, published: true,privacy: false, path: p.path, handler: { code,page in
                    
                     let comCon = CommentController()
                    comCon.page = page
                    self.navigationController?.show(comCon, sender: self)
                    
                })})
                
            })
            let act22 = UIAlertAction(title: "Back", style: .default, handler: {
                _ in
                //Go back to prev vc
                ac2.dismiss(animated: true, completion: { self.present(ac,animated: true)
                })
            })
            ac2.addAction(act21)
            ac2.addAction(act22)
            self.present(ac2,animated: true)
            })
        })

        ac.addAction(act1)
        ac.addAction(act2)
        present(ac,animated: true)
        
    }
    @objc func showBookMaker(){
     
        DispatchQueue.main.async {
            let bmCon = self.storyboard?.instantiateViewController(withIdentifier: "BookMakerController") as! BookMakerController
            bmCon.pages = self.pages
            self.navigationController?.show(bmCon, sender: self)
       
        }
    }
    @objc func showLibraryMaker(){}
    
}

