//
//  MarvelAPI.swift
//  Marvel
//
//  Created by Gonzalo Diz on 28/10/2021.
//

import CryptoKit
import Foundation

struct MarvelAPI {
    let privateAPIKey = "c21fb673ac1409317293024596bab17a431b2cea"
    let publicAPIKey = "21b35a858005faa92d2b89d4e5bc399c"
    var baseURL: URL? {
        URL(string: "https://gateway.marvel.com:443")
    }

    private let timestamp = "\(Date().timeIntervalSince1970)"

    var commonParameters: [String: String] {
        return [
            "hash": createHash(timestamp: timestamp),
            "ts": timestamp,
            "apikey": "\(publicAPIKey)"
        ]
    }

    var charactersURL: URL? {
        baseURL?.appendingPathComponent("/v1/public/characters")
    }

    private func createHash(timestamp: String) -> String {
        let data = "\(timestamp)\(privateAPIKey)\(publicAPIKey)".data(using: .utf8) ?? Data()
        let digest = Insecure.MD5.hash(data: data)

        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
}
