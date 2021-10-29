//
//  CharacterListViewModel.swift
//  Marvel
//
//  Created by Gonzalo Diz on 28/10/2021.
//

import Foundation

final class CharacterListViewModel {
    private let charactersService: CharactersService

    init(charactersService: CharactersService) {
        self.charactersService = charactersService
    }
}
