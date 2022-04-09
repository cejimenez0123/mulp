//
//  ModalContentSegue.swift
//  mulp
//
//  Created by Christian Jimenez on 3/26/22.
//

import Foundation
import UIKit


class ModalContentSeque: UIStoryboardSegue{
    
    override func perform() {
        destination.view.frame = CGRect.zero
        destination.view.center = source.view.center
            
        source.view.addSubview(destination.view)
        
        UIView.animate(withDuration: 0.3) {
            self.destination.view.frame = self.source.view.bounds.insetBy(dx: 50, dy: 200)
        }
    }
    
}
