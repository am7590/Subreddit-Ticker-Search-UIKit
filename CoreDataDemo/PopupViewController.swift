//
//  PopupViewController.swift
//  CoreDataDemo
//
//  Created by Alek Michelson on 2/8/22.
//

import UIKit

class PopupViewController: UIViewController {
    
    var name: String?
    
    
    @IBOutlet weak var subredditTextField: UITextField!
    
    
    @IBAction func returnButton(_ sender: Any) {
        print("\n\n")
        print(subredditTextField.text!)
        print("\n\n")
    }
    
 

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
}

