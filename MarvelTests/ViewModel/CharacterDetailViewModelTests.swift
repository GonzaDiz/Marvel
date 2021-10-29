//
//  CharacterDetailViewModelTests.swift
//  MarvelTests
//
//  Created by Gonzalo Diz on 29/10/2021.
//

import Foundation
import XCTest
@testable import Marvel
import RxSwift
import RxTest
import RxDataSources

class CharacterDetailViewModelTests: XCTestCase {
    private let scheduler: TestScheduler = TestScheduler(initialClock: 0)
    private let disposeBag = DisposeBag()
    private var viewModel: CharacterDetailViewModel!

    private var mockedComics: ItemList!
    private var mockedCharacter: Character!

    override func setUp() {
        super.setUp()

        mockedComics = ItemList(items: [Item(name: "Hulk #1"), Item(name: "Hulk #2")])
        mockedCharacter = Character(
            name: "Hulk",
            thumbnail: nil,
            description: "Description",
            comics: mockedComics,
            series: nil,
            stories: nil,
            events: nil
        )
        viewModel = CharacterDetailViewModel(character: mockedCharacter)
    }

    func test_viewModel_shouldEmitCharacterName_whenInitialized() {
        let titleObserver = scheduler.createObserver(String?.self)

        viewModel.title.bind(to: titleObserver).disposed(by: disposeBag)

        XCTAssertEqual(titleObserver.events.first?.value, .next("Hulk"))
    }

    func test_viewModel_shouldEmitSections_whenInitialized() {
        let sectionsObserver = scheduler.createObserver([SectionModel<String, Item>].self)

        viewModel.sections.bind(to: sectionsObserver).disposed(by: disposeBag)

        XCTAssertEqual(
            sectionsObserver.events.first?.value,
            .next(
                [
                    SectionModel(model: "Comics", items: mockedComics.items ?? []),
                    SectionModel(model: "Series", items: []),
                    SectionModel(model: "Stories", items: []),
                    SectionModel(model: "Events", items: [])
                ]
            )
        )
    }

    func test_viewModel_shouldEmitHeader_whenInitialized() {
        let headerObserver = scheduler.createObserver((imageURL: URL?, description: String?).self)

        viewModel.header.bind(to: headerObserver).disposed(by: disposeBag)

        XCTAssertEqual(headerObserver.events.first?.value.element?.imageURL, nil)
        XCTAssertEqual(headerObserver.events.first?.value.element?.description, "Description")

    }
}

extension Item: Equatable {
    public static func == (lhs: Item, rhs: Item) -> Bool {
        lhs.name == rhs.name
    }
}
