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
                let oldCharacters = self.characters.value
                self.characters.accept(oldCharacters + (characterDataContainer.results ?? []))
            case .failure:
                self.characters.accept([])
            }

            self.isLoading.accept(false)
        }.disposed(by: disposeBag)
    }
}
