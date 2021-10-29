//
//  CharactersCoordinatorTests.swift
//  MarvelTests
//
//  Created by Gonzalo Diz on 28/10/2021.
//

import Foundation
import XCTest
@testable import Marvel

class CharactersCoordinatorTests: XCTestCase {
    func test_coordinator_whenStarted_shouldPushCharacterListViewControllerInToNavigationController() {
        let navigationController = UINavigationController()
        let coordinator = CharactersCoordinator(navigationController: navigationController)

        coordinator.start()

        XCTAssertEqual(navigationController.viewControllers.count, 1)
        XCTAssertNotNil(navigationController.topViewController as? CharacterListViewController)
    }
}
