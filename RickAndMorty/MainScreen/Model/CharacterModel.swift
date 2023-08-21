//
//  CharacterModel.swift
//  RickAndMorty
//
//  Created by Pavel on 20.08.2023.
//

import UIKit

struct CharacterModel: Hashable {
    var id: Int
    var name: String
    var status: String
    var species: String
    var type: String
    var gender: String
    var origin: [String: String]
    var location: [String: String]
    var imageURL: String
    var episodesURLs: [String]
    var url: String
    var created: String
    
    var image: UIImage?
    
    init(dataResult: [String : AnyObject]) {
        self.id = dataResult["id"] as! Int
        self.name = dataResult["name"] as! String
        self.status = dataResult["status"] as! String
        self.species = dataResult["species"] as! String
        self.type = dataResult["type"] as! String
        self.gender = dataResult["gender"] as! String
        self.origin = dataResult["origin"] as! [String : String]
        self.location = dataResult["location"] as! [String : String]
        self.imageURL = dataResult["image"] as! String
        self.episodesURLs = dataResult["episode"] as! [String]
        self.url = dataResult["url"] as! String
        self.created = dataResult["created"] as! String
    }
}
