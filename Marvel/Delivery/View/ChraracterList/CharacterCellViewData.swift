//
//  CharacterCellViewData.swift
//  Marvel
//
//  Created by Gonzalo Diz on 30/10/2021.
//

import Foundation

struct CharacterCellViewData {
    var name: String? {
        character.name?.uppercased()
    }

    var imageURL: URL? {
        character.thumbnail?.url
    }

    var subtitle: String {
        let comicsCount = character.comics?.available ?? 0
        let seriesCount = character.comics?.available ?? 0
        let storiesCount = character.stories?.available ?? 0
        let eventsCount = character.events?.available ?? 0

        return """
        Comics: \(comicsCount)
        Series: \(seriesCount)
        Stories: \(storiesCount)
        Events: \(eventsCount)
        """
    }

    private let character: Character

    init(character: Character) {
        self.character = character
    }
}
