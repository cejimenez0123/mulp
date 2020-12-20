//
//  ViewController.swift
//  mulp
//
//  Created by /fam on 12/18/20.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textDisplay: UILabel!
    
    @IBAction func helloWorld(_ sender: Any) {
        textDisplay.text = "Hello, World!"
        print("Pressed Hello World button")
    }
    
    @IBAction func goodbyeWorld(_ sender: Any) {
        textDisplay.text = "Goodbye World"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        textDisplay.text = "Zzz..."
        // Do any additional setup after loading the view.
        print("viewDidLoad() called")
    }

    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            print("viewWillAppear(_:) called")
            view.backgroundColor = UIColor.red

        
        }
}


