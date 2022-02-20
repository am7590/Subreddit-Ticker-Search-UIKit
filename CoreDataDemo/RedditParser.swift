//
//  RedditParser.swift
//  AsyncProject
//
//  Created by Alek Michelson on 2/19/22.
//

import Foundation

class RedditParser {
    
    // Base components
    var hotComponents = URLComponents(string: "https://flask-service.bg7bq3bnlj1de.us-east-1.cs.amazonlightsail.com/hot/")
    var newComponents = URLComponents(string: "https://flask-service.bg7bq3bnlj1de.us-east-1.cs.amazonlightsail.com/new/")
    var hourComponents = URLComponents(string: "https://flask-service.bg7bq3bnlj1de.us-east-1.cs.amazonlightsail.com/subreddit-hour/")
    
    
    // Get URLComponent endpoints for new, hot, and hourly API requests
    func getNewRedditRequest(subreddit : String, posts : Int) -> URLComponents {
        newComponents?.queryItems = [
            URLQueryItem(name: "subreddit", value: subreddit),
            URLQueryItem(name: "new", value: String(posts))
        ]
        
        return newComponents!
    }
    
    
    func getHotRedditRequest(subreddit : String, posts : Int) -> URLComponents {
        hotComponents?.queryItems = [
            URLQueryItem(name: "subreddit", value: subreddit),
            URLQueryItem(name: "hot", value: String(posts))
        ]
        
        return hotComponents!
    }
    
    
    func getHourRedditRequest() -> URLComponents {
        hourComponents?.queryItems = [
            URLQueryItem(name: "subreddit", value: "stocks"),
            URLQueryItem(name: "hours", value: "24")
        ]
        
        return hourComponents!
    }
    
    
    func sortData(parsedJSON : APIStruct) -> [String : Int] {
        var tickers: [String] = []
        var frequencies: [Int] = []
    
        // Add tickers and frequencies to their arrays
        var strFrequencies: [String] = []
        for item in parsedJSON.content {
            tickers += item.keys
            strFrequencies += item.values
        }
                           
        // Convert frequencies from str -> int
        frequencies = strFrequencies.map { Int($0)!}
        
        // Make and sort a dict of ticker:frequency from the two arrays
        let apiDict = Dictionary(uniqueKeysWithValues: zip(tickers, frequencies))
        
//        let sortedApiDict = apiDict.sorted {
//            return $0.1 > $1.1
//        }
        
        return apiDict
        
    }
    
    
}
