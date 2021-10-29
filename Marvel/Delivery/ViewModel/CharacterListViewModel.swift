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
    
    private let charactersService: CharactersService
    private let disposeBag = DisposeBag()

    init(charactersService: CharactersService) {
        self.charactersService = charactersService
    }
    
    func listCharacters() {
        charactersService.getCharacterDataContainer().subscribe { [weak self] event in
            guard let self = self else { return }
            switch event {
            case let .success(characterDataContainer):
                self.characters.accept(characterDataContainer.results ?? [])
            case .failure:
                self.characters.accept([])
            }
        }.disposed(by: disposeBag)
    }
}
