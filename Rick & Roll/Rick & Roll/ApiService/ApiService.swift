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


