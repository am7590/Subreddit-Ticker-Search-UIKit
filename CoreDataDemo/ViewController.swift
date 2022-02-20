//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by Alek Michelson on 2/5/22.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    // Table view
    @IBOutlet weak var tableView: UITableView!
    
    // Important- exit detail view
    @IBAction func myUnwindAction(unwindSegue: UIStoryboardSegue) {}
    
    
    // Reference to managed object context (Core data)
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // TableView Data
    var items:[Person]?
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
    }
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        // Enable for better navigation bar
        // Bar Button Items
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(goToPopupView))
        navigationItem.rightBarButtonItems = [add]
        
        
        // TableView
        tableView.dataSource = self
        tableView.delegate = self
        
        
        // Connect from PopupViewController
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)
        
        // Get items from Core Data
        fetchPeople()
    }
    
    @objc func goToPopupView() {
        // Set up detail view controller
        let vc = storyboard?.instantiateViewController(withIdentifier: "PopupViewController") as! PopupViewController
        // guard let navController = self.navigationController else {return}
        // navController.pushViewController(vc, animated: true)
        
        self.present(vc, animated: true, completion: nil)
        
        
    }
    
    @objc func loadList(notification: NSNotification){
        fetchPeople()
    }
    
    func fetchPeople() {
        
        // Fetch data from core data
        do {
            self.items = try context.fetch(Person.fetchRequest())
            
            // Run on main thread
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
            
        } catch {
            
        }
        
    }


    
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return # of people
        return self.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
    
        UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "PersonCell", for: indexPath)
            
            // Get person from array; set label
            let person = self.items![indexPath.row]
            
            
            let cellText:String = person.name! + "\t  "  + String(person.age) +  " " + person.gender! + " posts searched"
            
            cell.textLabel?.text = cellText
            
            return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Set up detail view controller
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        
        // Get person
        let person = self.items![indexPath.row]
        
        // Edit labels
        vc?.subredditText = person.name ?? ""
        vc?.postsSearchedText = String(person.age)
        vc?.queryText = String()
        vc?.typeSearch = person.gender ?? ""
        
        

        
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        // Create swipe action
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            
            // Which person to remove
            let personToRemove = self.items![indexPath.row]
            
            // Remove person
            self.context.delete(personToRemove)
            
            // Save data
            do {
                try self.context.save()
            } catch {
                
            }
            
            // Re-fetch data
            self.fetchPeople()
            
        }
        
        return UISwipeActionsConfiguration(actions: [action])
        
    }
    
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction(style: .normal, title: "Edit") { (action, view, completionHandler) in
            
            // Selected Person
            let person = self.items![indexPath.row]
            
            // Create alert
            let alert = UIAlertController(title: "Edit Person", message: "Edit name:", preferredStyle: .alert)
            alert.addTextField(configurationHandler: { (subredditField) in
                subredditField.text = person.name
                subredditField.placeholder = "Subreddit"
            })
            alert.addTextField(configurationHandler: { (postsField) in
                postsField.text = String(person.age)
                postsField.placeholder = "Posts Searched:"
            })
            alert.addTextField(configurationHandler: { (searchType) in
                searchType.text = person.gender
                searchType.placeholder = "Search Type:"
            })
            
            // Config button handler
            let saveButton = UIAlertAction(title: "Save", style: .default) { (action) in
                
                // Get textfield for alert
                let subredditField = alert.textFields![0]
                let postsField = alert.textFields![1]
                let searchTypeField = alert.textFields![2]
                
                // Edit name property of person object
                person.name = subredditField.text
                let personAge:Int64 = Int64(postsField.text ?? "0") ?? 0
                person.age = personAge
                
                // Update search type
                person.gender = searchTypeField.text
                
                
                // Save data
                do {
                    try self.context.save()
                } catch {
                    
                }
                
                // Re-fetch data
                self.fetchPeople()
            }
            
            // Add button
            alert.addAction(saveButton)
            
            // Show alert
            self.present(alert, animated: true, completion: nil)
            
            
        }
            
        
        return UISwipeActionsConfiguration(actions: [action])
        
    }





}
    
    
    
    




