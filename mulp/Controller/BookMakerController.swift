//
//  BookMakerController.swift
//  mulp
//
//  Created by Christian Jimenez on 4/17/22.
//

import Foundation
import UIKit


class BookMakerController: UIViewController,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource{
    var pages = [Page]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
       
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.pages.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let nib = UINib(nibName: "BookMakerCollectionViewCell", bundle: Bundle(for: BookMakerCollectionViewCell.self))
        collectionView.register(nib, forCellWithReuseIdentifier: "BookMakerCollectionViewCell")
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "BookMakerCollectionViewCell", for: indexPath) as! BookMakerCollectionViewCell
        
                cell.page = self.pages[indexPath.section]
        
        
                return cell
        
    }
//
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 75, height: 75)
    }
}
