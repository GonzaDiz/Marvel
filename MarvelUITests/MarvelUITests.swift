//
//  MarvelUITests.swift
//  MarvelUITests
//
//  Created by Gonzalo Diz on 29/10/2021.
//

import XCTest
@testable import Marvel

class MarvelUITests: KIFTestCase {

    override func setUp() {
        super.setUp()
    }

    override func afterEach() {
        super.afterEach()
        removeAllStubs()
    }

    func test_firstCellName_equals_firstCharacterReturnedByAPI() {
        stub(pathEndsWith: "/v1/public/characters", file: "characters_mock.json")

        let tableView = tester().waitForView(withAccessibilityIdentifier: A11y.CharacterListView.tableView) as! UITableView

        let cell = tester().waitForCell(at: IndexPath(row: 0, section: 0), in: tableView) as! CharacterTableViewCell

        let cellLabel = cell.contentView.subviews.first {
            $0.accessibilityIdentifier == A11y.CharacterTableViewCell.nameLabel
        } as? UILabel

        XCTAssertEqual(cellLabel?.text, "3-D MAN")
    }
}
