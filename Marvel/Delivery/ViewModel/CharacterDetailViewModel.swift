//
//  CharacterDetailViewModel.swift
//  Marvel
//
//  Created by Gonzalo Diz on 29/10/2021.
//

import RxSwift

struct CharacterDetailViewModel {
    var title: Observable<String?>

    init(character: Character) {
        title = Observable.just(character.name)
    }
}
