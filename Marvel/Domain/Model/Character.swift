//
//  Character.swift
//  Marvel
//
//  Created by Gonzalo Diz on 28/10/2021.
//

import Foundation

struct Character: Decodable {
    let name: String?
    let thumbnail: Thumbnail?
    let description: String?
    let comics: ItemList?
    let series: ItemList?
    let stories: ItemList?
    let events: ItemList?
}
