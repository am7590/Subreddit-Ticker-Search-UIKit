//
//  PopupViewController.swift
//  CoreDataDemo
//
//  Created by Alek Michelson on 2/8/22.
//

import UIKit

class PopupViewController: UIViewController {
        
    // Reference to managed object context (Core data)
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // Input for which subreddit to search
    @IBOutlet weak var subredditTextField: UITextField!
    
    let v = ViewController()
    
    // Returns to 
    @IBAction func returnButton(_ sender: Any) {
        print("\n\n")
        print(subredditTextField.text!)
        print("\n\n")
        
        
        // Create person object
        let newPerson = Person(context: self.context)
        newPerson.name = subredditTextField.text!
        newPerson.age = 90
        newPerson.gender = "Male"
                
        // Save the data
        do {
            try  self.context.save()
        } catch {
            
        }
        
        // Refetch data
        // Fetch data from core data
        do {
        
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)

            
        } catch {
            
        }
        
    }
    
 

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
}

