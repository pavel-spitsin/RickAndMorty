//
//  MainScreenCoordinator.swift
//  RickAndMorty
//
//  Created by Pavel on 22.12.2023.
//

import UIKit

class MainScreenCoordinator: BaseCoordinator {
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() {
        let viewModel = MainScreenViewModel()
        let mainScreen = MainScreenView(viewModel: viewModel)
        mainScreen.coordinator = self
        navigationController.pushViewController(mainScreen, animated: true)
    }
    
    func runDetailsScreen(with data: Any) {
        let detailsScreenCoordinator = DetailsScreenCoordinator(navigationController: navigationController, 
                                                                data: data)
        add(coordinator: detailsScreenCoordinator)
        detailsScreenCoordinator.start()
    }
}
