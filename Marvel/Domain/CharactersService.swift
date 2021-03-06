//
//  CharactersService.swift
//  Marvel
//
//  Created by Gonzalo Diz on 28/10/2021.
//

import Alamofire
import RxSwift

protocol CharactersService {
    func getCharacterDataContainer(offset: Int, name: String?) -> Single<CharacterDataContainer>
}

final class LiveCharacterService: CharactersService {
    private let marvelAPI: MarvelAPI

    enum LiveCharactersListServiceError: Swift.Error {
        case characterDataContainerNotFound
        case charactersURLNotFound
    }

    init(marvelAPI: MarvelAPI) {
        self.marvelAPI = marvelAPI
    }

    func getCharacterDataContainer(offset: Int, name: String?) -> Single<CharacterDataContainer> {
        return Single.create { [weak self] observer in
            guard let self = self,
                  let url = self.marvelAPI.charactersURL
            else {
                observer(.failure(LiveCharactersListServiceError.charactersURLNotFound))
                return Disposables.create()
            }

            let task = AF.request(
                url,
                method: .get,
                parameters: self.getParameters(offset: offset, name: name)
            ).validate().responseDecodable(of: CharacterDataWrapper.self) { response in
                switch response.result {
                case let .success(characterDataWrapper):
                    guard let characterDataContainer = characterDataWrapper.data else {
                        observer(.failure(LiveCharactersListServiceError.characterDataContainerNotFound))
                        return
                    }
                    observer(.success(characterDataContainer))
                case .failure:
                    observer(.failure(LiveCharactersListServiceError.characterDataContainerNotFound))
                }
            }

            return Disposables.create {
                task.cancel()
            }
        }
    }

    private func getParameters(offset: Int, name: String?) -> [String: Any] {
        var parameters = [
            "offset": offset
        ].merging(self.marvelAPI.commonParameters) { current, _ in
            current
        }

        if let name = name, !name.isEmpty {
            parameters["nameStartsWith"] = name
        }

        return parameters
    }
}
