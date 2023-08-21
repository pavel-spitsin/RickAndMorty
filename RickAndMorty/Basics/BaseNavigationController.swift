//
//  BaseNavigationController.swift
//  RickAndMorty
//
//  Created by Pavel on 17.08.2023.
//

import UIKit

class BaseNavigationController : UINavigationController {
    
    //MARK: - View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.prefersLargeTitles = true
        navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: CustomColor.white ?? .white]
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: CustomColor.white ?? .white]
        navigationBar.barTintColor = CustomColor.blackBG
        navigationBar.tintColor = CustomColor.white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
}
