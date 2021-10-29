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

class CharacterDetailViewModelTests: XCTestCase {
    private let scheduler: TestScheduler = TestScheduler(initialClock: 0)
    private let disposeBag = DisposeBag()
    private var viewModel: CharacterDetailViewModel!

    private let mockedCharacter = Character(name: "Hulk", thumbnail: nil)

    override func setUp() {
        super.setUp()

        viewModel = CharacterDetailViewModel(character: mockedCharacter)
    }

    func test_viewModel_shouldEmitCharacterName_whenInitialized() {
        let titleObserver = scheduler.createObserver(String?.self)

        viewModel.title.bind(to: titleObserver).disposed(by: disposeBag)

        XCTAssertEqual(titleObserver.events.first?.value, .next("Hulk"))

    }
}
