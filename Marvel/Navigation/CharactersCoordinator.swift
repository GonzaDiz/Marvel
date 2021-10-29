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
        let service = LiveCharacterService(marvelAPI: MarvelAPI())
        let viewModel = CharacterListViewModel(charactersService: service)
        let viewController = CharacterListViewController(viewModel: viewModel) { [weak self] character in
            self?.showCharacterDetail(character)
        }
        navigationController.pushViewController(viewController, animated: true)
    }

    private func showCharacterDetail(_ character: Character) {
        let viewModel = CharacterDetailViewModel(character: character)
        let viewController = CharacterDetailViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
}
