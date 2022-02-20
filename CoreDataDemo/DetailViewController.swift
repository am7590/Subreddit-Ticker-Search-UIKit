//
//  DetailViewController.swift
//  CoreDataDemo
//
//  Created by Alek Michelson on 2/9/22.
//

import UIKit
import Charts

class DetailViewController: UIViewController {
    
    @IBOutlet weak var subreddit: UILabel!
    @IBOutlet weak var postsSearched: UILabel!
    @IBOutlet weak var query: UITextView!
    @IBOutlet weak var pieView: PieChartView!
    @IBOutlet weak var typeOfSearch: UILabel!
    
    let data = Data()
    var request = RedditParser()
    
    
    var subredditText = ""
    var postsSearchedText = ""
    var queryText = ""
    var typeSearch = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Update labels
        subreddit.text = "Subreddit searched: \(subredditText)"
        postsSearched.text = "Posts searched: \(postsSearchedText)"
        typeOfSearch.text = "Type of search: \(typeSearch)"
        
        
        parseIntoDict(subreddit: subredditText, posts: Int(postsSearchedText) ?? 0)
        //query.text = "Query: \(dataList)"
        
    }
    
    func parseIntoDict(subreddit : String, posts : Int) {
        var returnJSON : [String : Int] = [:]
    
        
        let component : URLComponents =  typeSearch == "New" ? request.getNewRedditRequest(subreddit: subreddit, posts: posts) : request.getHotRedditRequest(subreddit: subreddit, posts: posts)
        //let component : URLComponents = request.getNewRedditRequest(subreddit: subreddit, posts: posts)
        //let component : URLComponents = request.getHourRedditRequest()

        let urlRequest = URLRequest(url: component.url!)
        print(urlRequest.url ?? "Failed to load URL")
        

        // The URLSession class and related classes provide an API for downloading data from and uploading data to endpoints indicated by URLs.
        URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            if let data = data {
    
                // let json = String(data: data, encoding: .utf8)
                let jsonDecoder = JSONDecoder()
                
                do {
                    let parsedJSON = try jsonDecoder.decode(APIStruct.self, from: data)
                    
                    returnJSON = self.request.sortData(parsedJSON: parsedJSON)
                    
                    DispatchQueue.main.async {
                        self.setupPieChart(data: returnJSON)
                        self.query.text = returnJSON.description
                        //self.queryText.text = returnJSON.description
                    }

                } catch {
                    print("Error parsing JSON")
                }
            }
            
        }).resume()
        
    }
    
    
    func setupPieChart(data : [String : Int]) {
        pieView.chartDescription?.enabled = false
        pieView.legend.enabled = false // Disable legend
        pieView.drawHoleEnabled = true  // Draw hole
        pieView.rotationAngle = 0
        pieView.rotationEnabled = false
        pieView.isUserInteractionEnabled = true // enable interaction
        
        // Get data to put into pie chart
        var entries : [PieChartDataEntry] = Array()
        
        var count : Int = 0
        for (key, value) in data {
            if(count < 10 && value > 1) {
                entries.append(PieChartDataEntry(value: Double(value), label: key))
                count += 1
            }
            
            
        }
        
        // Create data set
        let dataSet = PieChartDataSet(entries: entries, label: "blank label")
        
        let color2 = NSUIColor(hex: 0x556B2F)
        let color3 = NSUIColor(hex: 0x4F0147)
        let color4 = NSUIColor(hex: 0xCAE1FF)
        let color5 = NSUIColor(hex: 0x1874CD)
        let color6 = NSUIColor(hex: 0xFF00FF)
        let color7 = NSUIColor(hex: 0xFF3030)
        
        dataSet.colors = [color2, color3, color4, color5, color6, color7]
        dataSet.drawValuesEnabled = false
        pieView.data = PieChartData(dataSet: dataSet)
        
    }
}
