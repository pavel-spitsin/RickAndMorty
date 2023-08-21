//
//  DetailsTableViewSourceManager.swift
//  RickAndMorty
//
//  Created by Pavel on 20.08.2023.
//

import UIKit

enum DetailsTableViewSourceManager: Int, CaseIterable {
    case mainDetails = 0
    case infoDetails = 1
    case originDetails = 2
    case episodesDetails = 3

    var heightForRow: CGFloat {
        switch self {
        case .mainDetails:
            return 249
        case .infoDetails:
            return 140
        case .originDetails:
            return 96
        case .episodesDetails:
            return 102
        }
    }
    
    var headerView: UIView? {
        switch self {
        case .mainDetails:
            return nil
        case .infoDetails:
            return DetailsSectionHeader(title: "Info")
        case .originDetails:
            return DetailsSectionHeader(title: "Origin")
        case .episodesDetails:
            return DetailsSectionHeader(title: "Episodes")
        }
    }
    
    func numberOfRowsInSection(viewModel: DetailsScreenViewModel) -> Int {
        guard let model = viewModel.characterDetailsModel else { return 0 }
        
        switch self {
        case .mainDetails:
            return 1
        case .infoDetails:
            return 1
        case .originDetails:
            return 1
        case .episodesDetails:
            return model.episodes.count
        }
    }
    
    func cellForRow(_ tableView: UITableView, cellForRowAt indexPath: IndexPath, viewModel: DetailsScreenViewModel) -> UITableViewCell? {
        guard let model = viewModel.characterDetailsModel else { return nil }
        var cell: DetailsCellProtocol?
        
        switch self {
        case .mainDetails:
            cell = tableView.dequeueReusableCell(withIdentifier: DetailsMainCell.identifier, for: indexPath) as? DetailsMainCell
        case .infoDetails:
            cell = tableView.dequeueReusableCell(withIdentifier: DetailsInfoCell.identifier, for: indexPath) as? DetailsInfoCell
        case .originDetails:
            cell = tableView.dequeueReusableCell(withIdentifier: DetailsOriginCell.identifier, for: indexPath) as? DetailsOriginCell
        case .episodesDetails:
            cell = tableView.dequeueReusableCell(withIdentifier: DetailsEpisodeCell.identifier, for: indexPath) as? DetailsEpisodeCell
        }

        cell?.fillCharacterDetails(character: model, index: indexPath.row)
        return cell
    }
}

protocol DetailsCellProtocol: UITableViewCell {
    func fillCharacterDetails(character: CharacterDetailsModel, index: Int)
}
