//
//  MarvelUITests.swift
//  MarvelUITests
//
//  Created by Gonzalo Diz on 29/10/2021.
//

import XCTest
@testable import Marvel

class MarvelUITests: KIFTestCase {

    private let charactersPath = "/v1/public/characters"

    override func afterEach() {
        super.afterEach()
        removeAllStubs()
        tester().tapView(withAccessibilityLabel: "Back")
    }

    func test_firstCellName_equals_firstCharacterReturnedByAPI() {
        stub(pathEndsWith: charactersPath, file: "characters_mock.json")

        showCharactersList()

        let tableView = tester().waitForView(withAccessibilityIdentifier: A11y.CharacterListView.tableView) as! UITableView

        let cell = tester().waitForCell(at: IndexPath(row: 0, section: 0), in: tableView) as! CharacterTableViewCell

        let cellLabel = cell.contentView.subviews.first {
            $0.accessibilityIdentifier == A11y.CharacterTableViewCell.nameLabel
        } as? UILabel

        XCTAssertEqual(cellLabel?.text, "3-D MAN")
    }

    func test_loadingView_isShown_whileAPIRequestIsBeingDone() {
        stub(pathEndsWith: charactersPath, file: "characters_mock.json", responseTime: 5)

        showCharactersList()

        let loadingView = tester().waitForView(
            withAccessibilityIdentifier: A11y.CharacterListView.loadingView
        )

        XCTAssertEqual(loadingView?.isHidden, false)
    }

    func test_errorView_isShown_whenAPIRequestFails() {
        stub(pathEndsWith: charactersPath, file: "characters_failure_mock.json")

        showCharactersList()

        let errorViewTitle = tester().waitForView(
            withAccessibilityIdentifier: A11y.PlaceholderView.titleLabel
        ) as! UILabel

        XCTAssertEqual(
            errorViewTitle.text,
            "Ups! We're sorry something is not working on our side, please try again later"
        )
    }

    func test_errorView_isShown_whenAPIReturnsNoCharacters() {
        stub(pathEndsWith: charactersPath, file: "no_characters_mock.json")

        showCharactersList()

        let errorViewTitle = tester().waitForView(
            withAccessibilityIdentifier: A11y.PlaceholderView.titleLabel
        ) as! UILabel

        XCTAssertEqual(
            errorViewTitle.text,
            "We couldn't find any character :("
        )
    }

    private func showCharactersList() {
        let charactersListTableView = tester().waitForView(
            withAccessibilityIdentifier: A11y.CharacterListView.tableView
        ) as! UITableView

        guard let navigationController = charactersListTableView.parentViewController?.navigationController else {
            XCTFail("Couldn't get navigation controller")
            return
        }

        let coordinator = CharactersCoordinator(navigationController: navigationController)
        coordinator.start()
    }
}
