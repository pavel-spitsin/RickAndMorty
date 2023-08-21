//
//  DetailsScreenViewModel.swift
//  RickAndMorty
//
//  Created by Pavel on 17.08.2023.
//

import Combine
import Foundation
import UIKit

final class DetailsScreenViewModel: ObservableObject {
    
    //MARK: - Properties
    
    private let character: CharacterModel

    //Subscribe in view
    @Published var characterDetailsModel: CharacterDetailsModel?
    
    //MARK: - Init
    
    init(character: CharacterModel) {
        self.character = character
        updateDetailsModel()
    }
    
    //MARK: - Actions
    
    private func updateDetailsModel() {
        var episodes = [EpisodeModel]()
        let locationURL = character.location["url"]
        var location: LocationModel?
        
        let group = DispatchGroup()
        
        group.enter()
        guard let locationURL else { return }
        RequestService.getDataByURL(urlString: locationURL) { data in
            guard let data else { return }
            location = LocationModel(data: data)
            group.leave()
        }

        character.episodesURLs.forEach {
            group.enter()
            RequestService.getDataByURL(urlString: $0) { data in
                guard let data else { return }
                let episode = EpisodeModel(data: data)
                episodes.append(episode)
                group.leave()
            }
        }

        group.notify(queue: .global(qos: .background)) {
            guard let location else { return }
            let sortedEpisodes = episodes.sorted { a, b in
                a.id < b.id
            }
            self.characterDetailsModel = CharacterDetailsModel(character: self.character, location: location, episodes: sortedEpisodes)
        }
    }
}
