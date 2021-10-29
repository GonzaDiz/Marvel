//
//  CharacterDetailViewModel.swift
//  Marvel
//
//  Created by Gonzalo Diz on 29/10/2021.
//

import Foundation
import RxSwift
import RxDataSources

struct CharacterDetailViewModel {
    var title: Observable<String?>
    var sections: Observable<[SectionModel<String, Item>]>
    var header: Observable<(imageURL: URL?, description: String?)>

    init(character: Character) {
        title = Observable.just(character.name)
        sections = Observable.just([
            SectionModel(model: "Comics", items: character.comics?.items ?? []),
            SectionModel(model: "Series", items: character.series?.items ?? []),
            SectionModel(model: "Stories", items: character.stories?.items ?? []),
            SectionModel(model: "Events", items: character.events?.items ?? [])
        ])
        header = Observable.just(
            (
                imageURL: character.thumbnail?.url,
                description: character.description
            )
        )
    }
}
