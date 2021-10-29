//
//  Thumbnail.swift
//  Marvel
//
//  Created by Gonzalo Diz on 28/10/2021.
//

import Foundation

struct Thumbnail: Decodable {
    var url: URL? {
        guard let path = path, let pathExtension = `extension` else {
            return nil
        }

        return URL(string: "\(path).\(pathExtension)")
    }

    let path: String?
    let `extension`: String?
}
