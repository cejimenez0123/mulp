//
//  BookMakerController.swift
//  mulp
//
//  Created by Christian Jimenez on 4/17/22.
//

import Foundation
import UIKit


class MakerController:UIViewController{
    var user = globalVars.currentUser
    var pages = [Page]()
    var books = [Book]()
    let pageClient = PageClient()
    @IBOutlet weak var pageButton: UIButton!
    @IBOutlet weak var bookButton: UIButton!
    @IBOutlet weak var libraryButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        pageButton.addTarget(self, action: #selector(showPageMaker), for: .touchUpInside)
        bookButton.addTarget(self, action: #selector(showBookMaker), for: .touchUpInside)
        
    }
    @objc func showPageMaker(){}
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

