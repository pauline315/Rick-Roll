//
//  ApiService.swift
//  Rick & Roll
//
//  Created by Gracie on 24/09/2024.
//

import Foundation
class APIService {
    func fetchCharacters(page: Int) -> Observable<CharacterData> {
        let url = URL(string: "https://rickandmortyapi.com/api/character?page=\(page)")!
         return Observable.create { observer in
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    observer.onError(error)
                } else if let data = data {
                     do {
                        let characterData = try JSONDecoder().decode(CharacterData.self, from: data)
                        observer.onNext(characterData)
                        observer.onCompleted()
                    } catch let jsonError {
                        observer.onError(jsonError)
                    }
                }
            }
                                    task.resume()
            return Disposables.create {
                task.cancel()
            }
        }
    }
}


