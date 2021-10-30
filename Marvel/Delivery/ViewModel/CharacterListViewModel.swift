//
//  CharacterListViewModel.swift
//  Marvel
//
//  Created by Gonzalo Diz on 28/10/2021.
//

import RxSwift
import RxRelay

final class CharacterListViewModel {
    let characters = BehaviorRelay<[Character]>(value: [])
    let filteredCharacters = BehaviorRelay<[Character]>(value: [])
    let isLoading = BehaviorRelay<Bool>(value: false)
    let error = BehaviorSubject<String>(value: "")

    private let charactersService: CharactersService
    private let disposeBag = DisposeBag()
    private var offset = 0

    init(charactersService: CharactersService) {
        self.charactersService = charactersService
    }

    func listCharacters(filteredBy text: String? = nil) {
        if isLoading.value { return }
        isLoading.accept(true)

        charactersService.getCharacterDataContainer(
            offset: offset,
            name: text
        ).subscribe { [weak self] event in
            guard let self = self else { return }
            self.isLoading.accept(false)

            switch event {
            case let .success(characterDataContainer):
                self.offset += characterDataContainer.count ?? 0
                let updatedCharacters = self.characters.value + (characterDataContainer.results ?? [])

                if updatedCharacters.isEmpty {
                    self.error.onNext("We couldn't find any character")
                } else {
                    self.characters.accept(updatedCharacters)
                }
            case .failure:
                self.error.onNext("Ups! We're sorry something went wrong, please try again later")
            }

        }.disposed(by: disposeBag)
    }

    func searchCharacters(filteredBy text: String?) {
        offset = 0
        characters.accept([])
        listCharacters(filteredBy: text)
    }
}
