//
//  ApiService.swift
//  Rick & Roll
//
//  Created by Gracie on 24/09/2024.
//

import Foundation
import RxSwift

class APIService {
    func fetchCharacters(status: String?, page: Int, pageSize: Int) -> Observable<CharacterData> {
        let urlString = "https://rickandmortyapi.com/api/character?status=\(status ?? "")&page=\(page)&pageSize=\(pageSize)"
        guard let url = URL(string: urlString) else {
            return Observable.error(NSError(domain: "Invalid URL", code: -1, userInfo: nil))
        }
        
        return Observable.create { observer in
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    observer.onError(error)
                } else if let data = data {
                    do {
                        // Decode the response into CharacterData
                        let decodedResponse = try JSONDecoder().decode(CharacterData.self, from: data)
                        observer.onNext(decodedResponse)
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
