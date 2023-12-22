//
//  AppDelegate.swift
//  RickAndMorty
//
//  Created by Pavel on 17.08.2023.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    //MARK: - Properties
    
    var window: UIWindow?
    var appCoordinator: AppCoordinator?
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreData")
        container.loadPersistentStores { description, error in
            if let error {
                print(error.localizedDescription)
            } else {
                print("DB url -", description.url?.absoluteString ?? "")
            }
        }
        return container
    }()
    
    //MARK: - App Life Cycle

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Thread.sleep(forTimeInterval: 1.0) //Just to show LaunchScreen for 1 second
        self.window = UIWindow(frame: UIScreen.main.bounds)
        if let window {
            appCoordinator = AppCoordinator(window: window)
            appCoordinator?.start()
        }
        return true
    }
    
    //MARK: - Actions
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                fatalError(error.localizedDescription)
            }
        }
    }
}
