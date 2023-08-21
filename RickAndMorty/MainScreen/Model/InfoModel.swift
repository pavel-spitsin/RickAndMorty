//
//  InfoModel.swift
//  RickAndMorty
//
//  Created by Pavel on 20.08.2023.
//

import Foundation

struct InfoModel {
    var count: Int
    var pages: Int
    var next: String?
    var prev: String?
    
    init(dataInfo: [String : AnyObject]) {
        self.count = dataInfo["count"] as! Int
        self.pages = dataInfo["pages"] as! Int
        self.next = dataInfo["next"] as? String
        self.prev = dataInfo["prev"] as? String
    }
}
