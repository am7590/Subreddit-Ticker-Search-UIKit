//
//  Data.swift
//  WSB API Test
//
//  Created by Alek Michelson on 1/4/22.
//

import Foundation

class Data : ObservableObject {
    @Published var dataHasLoaded = false
    @Published var tickerObjects: [TickerStruct] = []
    @Published var posts: Int = 0
    @Published var freq: [Int] = []
}


// New link: "https://flask-service.bg7bq3bnlj1de.us-east-1.cs.amazonlightsail.com/new/?new=10"
// Hot link: "https://flask-service.bg7bq3bnlj1de.us-east-1.cs.amazonlightsail.com/hot/?hot=10"

extension Data {
    
    // Creates a map of frequency/ticker sorted by frequency values for the pie chart
//    static func entriesForBarChart(_ ticker: [TickerStruct]) -> [PieChartDataEntry] {
//        let requestedTickers = ticker.sorted { (a, b) -> Bool in
//            return a.frequency > b.frequency
//        }
//        
//        print(requestedTickers)
//        return requestedTickers.map { PieChartDataEntry(value: Double($0.frequency), label: $0.ticker)}
//        }
    
    func getData(urlString : String) -> [TickerStruct] {
        var output : [TickerStruct] = []
        var tickers: [String] = []
        var strFrequencies: [String] = []
        var frequencies: [Int] = []
        //let urlString: String = "https://flask-service.bg7bq3bnlj1de.us-east-1.cs.amazonlightsail.com/new/?subreddit=pennystocks&new=50"
        if let url = URL(string: urlString) {
        URLSession.shared.dataTask(with: url) { data, response, error in
           if let data = data {
               let jsonDecoder = JSONDecoder()
               do {
                   let parsedJSON = try jsonDecoder.decode(APIStruct.self, from: data)
                   print("Successfully retrieved data from \(parsedJSON.posts) Posts:")
                   print(parsedJSON)
                   self.posts = parsedJSON.posts
                   
                   // Add tickers and frequencies to their arrays
                   for item in parsedJSON.content {
                       tickers += item.keys
                       strFrequencies += item.values
                   }
                                      
                   // Convert frequencies from str -> int
                   frequencies = strFrequencies.map { Int($0)!}
                        
                   
                   // Sort into tuple lists: [(ticker, frequency)...]
                   var i : Int = 0
                   tickers.forEach { t in
                       self.tickerObjects.append(TickerStruct(index: 100, ticker: tickers[i], frequency: frequencies[i], largestFreq: 0, pixelWidth: 0))
                       i += 1
                   }


                   // Sort list of ticker objects
                   self.tickerObjects = self.tickerObjects.sorted(by: {$0.frequency>$1.frequency})
                   print(self.tickerObjects)

                   // Get largest frequency and update list of objects
                   let largest : Int = self.tickerObjects[0].frequency
                   for i in 0..<self.tickerObjects.count {
                       self.tickerObjects[i].largestFreq = largest
                       //self.tickerObjects[i].pixelWidth = (CGFloat(self.tickerObjects[i].frequency)/CGFloat(largest)*200)
                   }


                   // Add index values after they are sorted by frequency
                   self.freq = frequencies.sorted()
                   for i in 0..<self.tickerObjects.count {
                       self.tickerObjects[i].index = i
                   }

                   
                   self.dataHasLoaded = true
                   
                   output = self.tickerObjects
                   print(self.tickerObjects)
                   
               } catch {
                   self.dataHasLoaded = false
                   print(error)
               }
              
            }
        }.resume()
        }
        
        return output
        
    }
}
