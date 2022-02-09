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
    
    // Input for # of posts to search
    @IBOutlet weak var postNumberTextField: UITextField!
    
    
    let v = ViewController()
    
    // Returns to 
    @IBAction func returnButton(_ sender: Any) {
        print("\n\n")
        print(subredditTextField.text!)
        print("\n\n")
        
        
        // Hot posts: subreddit, # of posts https://flask-service.bg7bq3bnlj1de.us-east-1.cs.amazonlightsail.com/hot/?subreddit=wallstreetbets&hot=100
        // New posts: subreddit, # of posts https://flask-service.bg7bq3bnlj1de.us-east-1.cs.amazonlightsail.com/new/?subreddit=pennystocks&new=50
        // Custom posts: subreddit, # of hours https://flask-service.bg7bq3bnlj1de.us-east-1.cs.amazonlightsail.com/subreddit-hour/?subreddit=stocks&hours=24
        
        // Create person object
        let newPerson = Person(context: self.context)
        newPerson.name = subredditTextField.text!
        newPerson.age = Int64(postNumberTextField.text!) ?? 0
        newPerson.gender = "Male"
                
        // Save the data
        do {
            try  self.context.save()
        } catch {
            
        }
        
        // Reload data in ViewController
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)

    }
    
    
    // Segmented Control
    @IBAction func didChangeSegment(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            // Selected new
            view.backgroundColor = .systemBackground
        }
        
        else if sender.selectedSegmentIndex == 1 {
            // Selected hot
            view.backgroundColor = .gray
        }
        
        else if sender.selectedSegmentIndex == 2 {
            // Selected custom
            view.backgroundColor = .darkGray
        }
    }
    
 

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
}

