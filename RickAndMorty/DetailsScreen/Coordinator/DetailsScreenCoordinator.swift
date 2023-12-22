//
//  DetailsScreenCoordinator.swift
//  RickAndMorty
//
//  Created by Pavel on 22.12.2023.
//

import UIKit

class DetailsScreenCoordinator: BaseCoordinator {
    private var navigationController: UINavigationController
    var data: Any
    
    init(navigationController: UINavigationController, data: Any) {
        self.navigationController = navigationController
        self.data = data
    }
    
    override func start() {
        guard let characterModel = data as? CharacterModel else { return }
        let viewModel = DetailsScreenViewModel(character: characterModel)
        let detailsScreen = DetailsScreenView(viewModel: viewModel)
        detailsScreen.coordinator = self
        navigationController.pushViewController(detailsScreen, animated: true)
    }
}
