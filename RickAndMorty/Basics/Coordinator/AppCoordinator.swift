//
//  AppCoordinator.swift
//  RickAndMorty
//
//  Created by Pavel on 22.12.2023.
//

import UIKit

class AppCoordinator: BaseCoordinator {
    private var window: UIWindow
    
    private var navigationController: UINavigationController = {
        let navigationController = BaseNavigationController()
        return navigationController
    }()
    
    init(window: UIWindow) {
        self.window = window
        self.window.rootViewController = navigationController
        self.window.makeKeyAndVisible()
    }
    
    override func start() {
        let mainScreenCoordinator = MainScreenCoordinator(navigationController: navigationController)
        add(coordinator: mainScreenCoordinator)
        mainScreenCoordinator.start()
    }
}
