//
//  LocationModel.swift
//  RickAndMorty
//
//  Created by Pavel on 20.08.2023.
//

import Foundation

struct LocationModel {
    var id: Int
    var name: String
    var type: String
    var dimension: String
    var residents: [String]
    var url: String
    var created: String
    
    init(data: [String : AnyObject]) {
        self.id = data["id"] as! Int
        self.name = data["name"] as! String
        self.type = data["type"] as! String
        self.dimension = data["dimension"] as! String
        self.residents = data["residents"] as! [String]
        self.url = data["url"] as! String
        self.created = data["created"] as! String
    }
}
