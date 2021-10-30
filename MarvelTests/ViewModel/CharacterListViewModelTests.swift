//
//  CharacterListViewModelTests.swift
//  MarvelTests
//
//  Created by Gonzalo Diz on 28/10/2021.
//

import Foundation
import XCTest
@testable import Marvel
import RxSwift
import RxTest

class CharacterListViewModelTests: XCTestCase {
    private let scheduler: TestScheduler = TestScheduler(initialClock: 0)
    private let disposeBag = DisposeBag()
    private var charactersServiceSpy: CharactersServiceSpy!
    private var viewModel: CharacterListViewModel!

    override func setUp() {
        super.setUp()

        charactersServiceSpy = CharactersServiceSpy()
        viewModel = CharacterListViewModel(charactersService: charactersServiceSpy)
    }

    func test_viewModel_whenListCharactersIsInvoked_shouldGetCharactersFromService() {
        let mockedCharacters = [
            Character(
                name: "Spider-Man",
                thumbnail: nil,
                description: "Description",
                comics: nil,
                series: nil,
                stories: nil,
                events: nil
            )]
        let mockedCharacterDataContainer = CharacterDataContainer(results: mockedCharacters, count: 1)

        charactersServiceSpy.stubbedGetCharacterDataContainerResult = Single.just(mockedCharacterDataContainer)

        let charactersObserver = scheduler.createObserver([Character].self)

        viewModel.characters.asDriver().drive(charactersObserver).disposed(by: disposeBag)

        scheduler.scheduleAt(0) { [weak self] in
            self?.viewModel.listCharacters()
        }

        scheduler.start()

        XCTAssertEqual(
            charactersObserver.events,
            [
                .next(0, []),
                .next(0, mockedCharacters)
            ]
        )

        XCTAssertEqual(charactersServiceSpy.invokedGetCharacterDataContainer, true)
        XCTAssertEqual(charactersServiceSpy.invokedGetCharacterDataContainerCount, 1)
    }

    func test_viewModel_whenNoCharactersAreFound_returnsError() {
        charactersServiceSpy.stubbedGetCharacterDataContainerResult = Single.just(CharacterDataContainer(results: [], count: 0))

        let errorObserver = scheduler.createObserver(String.self)

        viewModel.error.asDriver(onErrorJustReturn: "").drive(errorObserver).disposed(by: disposeBag)

        scheduler.scheduleAt(0) { [weak self] in
            self?.viewModel.listCharacters()
        }

        scheduler.start()

        XCTAssertEqual(
            errorObserver.events,
            [
                .next(0, ""),
                .next(0, "We couldn't find any character :(")
            ]
        )
    }

    func test_viewModel_whenServiceFails_returnsError() {
        charactersServiceSpy.stubbedGetCharacterDataContainerResult = {
            return Single.create { observer in
                observer(.failure(NSError(domain: "", code: 0, userInfo: nil)))
                return Disposables.create()
            }
        }()

        let errorObserver = scheduler.createObserver(String.self)

        viewModel.error.asDriver(onErrorJustReturn: "").drive(errorObserver).disposed(by: disposeBag)

        scheduler.scheduleAt(0) { [weak self] in
            self?.viewModel.listCharacters()
        }

        scheduler.start()

        XCTAssertEqual(
            errorObserver.events,
            [
                .next(0, ""),
                .next(0, "Ups! We're sorry something is not working on our side, please try again later")
            ]
        )
    }
}

private class CharactersServiceSpy: CharactersService {
    var invokedGetCharacterDataContainer = false
    var invokedGetCharacterDataContainerCount = 0
    var stubbedGetCharacterDataContainerResult: Single<CharacterDataContainer>!

    func getCharacterDataContainer(offset: Int) -> Single<CharacterDataContainer> {
        invokedGetCharacterDataContainer = true
        invokedGetCharacterDataContainerCount += 1
        return stubbedGetCharacterDataContainerResult
    }
}

extension Character: Equatable {
    public static func == (lhs: Character, rhs: Character) -> Bool {
        return lhs.name == rhs.name && lhs.description == rhs.description
    }
}
