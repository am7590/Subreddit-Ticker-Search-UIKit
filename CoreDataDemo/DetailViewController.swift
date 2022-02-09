//
//  DetailViewController.swift
//  CoreDataDemo
//
//  Created by Alek Michelson on 2/9/22.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var subreddit: UILabel!
    @IBOutlet weak var postsSearched: UILabel!
    @IBOutlet weak var query: UILabel!
    
    let data = Data()
    
    var subredditText = ""
    var postsSearchedText = ""
    var queryText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Update labels
        subreddit.text = "Subreddit searched: \(subredditText)"
        postsSearched.text = "Posts searched: \(postsSearchedText)"
        let dataList:[TickerStruct] = data.getData(urlString: "https://flask-service.bg7bq3bnlj1de.us-east-1.cs.amazonlightsail.com/new/?subreddit=\(subredditText)&new=\(postsSearchedText)")
        query.text = "Query: \(dataList.count)"
        
    }
    
    
    // Hot posts: subreddit, # of posts https://flask-service.bg7bq3bnlj1de.us-east-1.cs.amazonlightsail.com/hot/?subreddit=wallstreetbets&hot=100
    // New posts: subreddit, # of posts https://flask-service.bg7bq3bnlj1de.us-east-1.cs.amazonlightsail.com/new/?subreddit=pennystocks&new=50
    // Custom posts: subreddit, # of hours https://flask-service.bg7bq3bnlj1de.us-east-1.cs.amazonlightsail.com/subreddit-hour/?subreddit=stocks&hours=24
    

}
