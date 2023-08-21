//
//  EpisodeModel.swift
//  RickAndMorty
//
//  Created by Pavel on 20.08.2023.
//

import Foundation

struct EpisodeModel {
    var id: Int
    var name: String
    var air_date: String
    var episode: String
    var characters: [String]
    var url: String
    var created: String

    init(data: [String : AnyObject]) {
        self.id = data["id"] as! Int
        self.name = data["name"] as! String
        self.air_date = data["air_date"] as! String
        self.episode = data["episode"] as! String
        self.characters = data["characters"] as! [String]
        self.url = data["url"] as! String
        self.created = data["created"] as! String
    }
}
