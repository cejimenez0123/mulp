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
    let bookClient = BookClient()
    @IBOutlet weak var pageButton: UIButton!
    @IBOutlet weak var bookButton: UIButton!
    @IBOutlet weak var libraryButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        pageButton.addTarget(self, action: #selector(showPageMaker), for: .touchUpInside)
        bookButton.addTarget(self, action: #selector(showBookMaker), for: .touchUpInside)
        if self.user.id.count > 0 {
        self.bookClient.getBooksOfUser(user_id: self.user.id, handler: { booksArr in
            
          self.books = booksArr
        })}
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            dismiss(animated: true)
        }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        picker.dismiss(animated: true, completion: nil)
        let pag = Page(id: "", path: "", type: "")
    
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
                    let mainCon = MainViewController()
                    mainCon.pages = pages
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
            ac.dismiss(animated: true, completion: {})
            self.present(self.imagePicker,animated: true)
        })
        let act2 = UIAlertAction(title: "Link", style: .default, handler: {[self] _ in
            ac.dismiss(animated: true, completion: {
        let ac2 = UIAlertController(title: "Add Link", message: "", preferredStyle: .alert)
            ac2.addTextField(configurationHandler:{_ in })
            let act21 = UIAlertAction(title: "Save", style: .default, handler: { _ in
                //Save Link
                let p = Page(id:"",path: ac2.textFields?[0].text ?? "", type:"Link")
                ac2.dismiss(animated: true, completion: {
               
                pageClient.uploadPage(userId: user.id, bookId: "", type: p.type, published: true,privacy: false, path: p.path, handler: { code,page in
                    DispatchQueue.main.async {
                    
                     let comCon = CommentController()
                        comCon.page = page
                        if let navCon = self.navigationController {
                        var stack = navCon.viewControllers
                        stack.remove(at: stack.count -   1)
                        stack.insert(comCon, at: stack.count)
                        navCon.setViewControllers(stack, animated: true)
                     }
                    }
                    })
                    
                })
                
            })
            let act22 = UIAlertAction(title: "Back", style: .default, handler: {
                _ in
                //Go back to prev vc
                ac2.dismiss(animated: true, completion: { self.present(ac,animated: true)
                })
            })
            ac2.addAction(act22)
            ac2.addAction(act21)
            
            self.present(ac2,animated: true)
            })
        })
        let act3 = UIAlertAction(title: "Cancel", style: .default, handler: {_ in ac.dismiss(animated: true, completion: {})})
        ac.addAction(act1)
        ac.addAction(act2)
        ac.addAction(act3)
        present(ac,animated: true)
        
    }
    @objc func showBookMaker(){
     
        DispatchQueue.main.async {
            let pcCon = self.storyboard?.instantiateViewController(withIdentifier: "PageCollectionController") as! PageCollectionController
            pcCon.books = self.books
            pcCon.pages = self.pages
            
            self.navigationController?.show(pcCon, sender: self)
       
        }
    }
    @objc func showLibraryMaker(){}
    
}

