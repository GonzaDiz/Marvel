//
//  CharacterServiceTests.swift
//  MarvelTests
//
//  Created by Gonzalo Diz on 28/10/2021.
//

import Foundation
import XCTest
@testable import Marvel

class CharacterServiceTests: XCTestCase {
    let path = "/v1/public/characters"
    let marvelAPI = MarvelAPI()
    var service: CharactersService!

    override func setUp() {
        super.setUp()
        service = LiveCharacterService(marvelAPI: marvelAPI)
    }

    override func tearDown() {
        super.tearDown()
        removeAllStubs()
    }

    func test_charactersService_whenAPIReturnsCharacters_shouldAlsoReturnCharacters() {
        stub(pathEndsWith: path, file: "characters_mock.json")

        let expectation = XCTestExpectation(description: "Get character data container should succeed")

        _ = service.getCharacterDataContainer().subscribe { event in
            switch event {
            case let .success(characterDataContainer):
                XCTAssertEqual(characterDataContainer.count, 2)
                XCTAssertEqual(characterDataContainer.results?.first?.name, "3-D Man")
                expectation.fulfill()
            case .failure:
                XCTFail()
            }
        }

        wait(for: [expectation], timeout: 3)
    }

    func test_characterService_whenAPIFails_shouldReturnFailure() {
        stub(pathEndsWith: path, file: "characters_failure_mock.json")

        let expectation = XCTestExpectation(description: "Get character data container should fail")
        
        _ = service.getCharacterDataContainer().subscribe { event in
            switch event {
            case .success:
                XCTFail()
            case .failure:
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 3)
    }
}
