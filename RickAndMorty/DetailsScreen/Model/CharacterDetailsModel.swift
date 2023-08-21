//
//  CharacterDetailsModel.swift
//  RickAndMorty
//
//  Created by Pavel on 20.08.2023.
//

import Foundation

struct CharacterDetailsModel {
    var character: CharacterModel
    var location: LocationModel
    var episodes: [EpisodeModel]
    
    init(character: CharacterModel, location: LocationModel, episodes: [EpisodeModel]) {
        self.character = character
        self.location = location
        self.episodes = episodes
    }
}
