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
    var flowLayout: UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout()

        // edit properties here
        let r = CGFloat(297/420)
        let w = (UIScreen.main.bounds.width - 40) / 2
        let h = w / r
        flowLayout.itemSize = CGSize(width: 169, height: 239)
        flowLayout.sectionInset = UIEdgeInsets(top: 7, left: 5, bottom: 7, right: 5)
        flowLayout.scrollDirection = UICollectionView.ScrollDirection.vertical
        flowLayout.minimumInteritemSpacing = 0.0
        // edit properties here

        return flowLayout
    }
  
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.allowsMultipleSelection = true
        collectionView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))

        self.collectionView.addGestureRecognizer(tap)

        self.collectionView.isUserInteractionEnabled = true
    }
    


    @objc func handleTap(_ sender: UITapGestureRecognizer) {
       if let indexPath = self.collectionView?.indexPathForItem(at: sender.location(in: self.collectionView)) {
    //Do your stuff here
        let cell = collectionView.cellForItem(at: indexPath) as! BookMakerCollectionViewCell
           if cell.isSelected {
               cell.isSelected = false
           }else {
               cell.isSelected = true}
    }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = self.collectionView(collectionView, cellForItemAt: indexPath) as! BookMakerCollectionViewCell
        
        
    }
    
    override func viewWillLayoutSubviews() {
        self.collectionView.collectionViewLayout = flowLayout
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
  
    

}
