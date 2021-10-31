//
//  ItemList.swift
//  Marvel
//
//  Created by Gonzalo Diz on 29/10/2021.
//

import Foundation

struct ItemList: Decodable {
    let items: [Item]?
    let available: Int?
}
