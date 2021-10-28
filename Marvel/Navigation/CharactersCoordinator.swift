//
//  CharactersCoordinator.swift
//  Marvel
//
//  Created by Gonzalo Diz on 28/10/2021.
//

import UIKit

protocol Coordinator {
    func start()
}

final class CharactersCoordinator: Coordinator {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .red
        navigationController.pushViewController(viewController, animated: true)
    }
}
