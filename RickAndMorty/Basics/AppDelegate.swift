//
//  AppDelegate.swift
//  RickAndMorty
//
//  Created by Pavel on 17.08.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    //MARK: - Properties
    
    var window: UIWindow?
    
    //MARK: - App Life Cycle

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Thread.sleep(forTimeInterval: 1.0) //Just to show LaunchScreen for 1 second
        self.window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = BaseNavigationController(rootViewController: MainScreenView(viewModel: MainScreenViewModel()))
        window?.makeKeyAndVisible()
        return true
    }
}

