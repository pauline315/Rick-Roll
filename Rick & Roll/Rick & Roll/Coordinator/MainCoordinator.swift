//
//  MainCoordinator.swift
//  Rick & Roll
//
//  Created by Gracie on 25/09/2024.
//

import UIKit

class MainCoordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        // Pass self (the MainCoordinator instance) to the CharacterListViewController
        let vc = CharacterListViewController(coordinator: self)
        navigationController.pushViewController(vc, animated: false)
    }

    func showCharacterDetails(character: Character) {
        let detailVC = CharacterDetailsViewController()
        // Pass character data to the detail view controller
        //detailVC.character = character
        navigationController.pushViewController(detailVC, animated: true)
    }
}
