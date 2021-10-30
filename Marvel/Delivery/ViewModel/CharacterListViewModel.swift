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
    let isLoading = BehaviorRelay<Bool>(value: false)
    let error = BehaviorSubject<String>(value: "")

    private let charactersService: CharactersService
    private let disposeBag = DisposeBag()
    private var offset = 0

    init(charactersService: CharactersService) {
        self.charactersService = charactersService
    }

    func listCharacters() {
        if isLoading.value { return }
        isLoading.accept(true)

        charactersService.getCharacterDataContainer(offset: offset).subscribe { [weak self] event in
            guard let self = self else { return }
            switch event {
            case let .success(characterDataContainer):
                self.offset += characterDataContainer.count ?? 0
                let updatedCharacters = self.characters.value + (characterDataContainer.results ?? [])

                guard !updatedCharacters.isEmpty else {
                    self.error.onNext("We couldn't find any character :(")
                    return
                }
                self.characters.accept(updatedCharacters)
            case .failure:
                self.error.onNext("Ups! We're sorry something is not working on our side, please try again later")
            }

            self.isLoading.accept(false)
        }.disposed(by: disposeBag)
    }
}
