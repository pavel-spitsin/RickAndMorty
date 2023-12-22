//
//  BaseCoordinator.swift
//  RickAndMorty
//
//  Created by Pavel on 22.12.2023.
//

import Foundation

class BaseCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    func start() {
        fatalError("Child should implement funcStart")
    }
}
