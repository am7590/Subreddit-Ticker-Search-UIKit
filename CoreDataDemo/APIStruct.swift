//
//  APIStruct.swift
//  CoreDataDemo
//
//  Created by Alek Michelson on 2/9/22.
//

import Foundation

struct APIStruct : Decodable {
    var type: String
    var posts: Int
    var content: [Dictionary<String, String>]
    var time_called: String
    var time_compiled: String
}

struct APITimeStruct : Decodable {
    var type: String
    var content: [Dictionary<String, String>]
    var time_called: String
    var time_compiled: String
}

