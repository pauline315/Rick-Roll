//
//  Model.swift
//  Rick & Roll
//
//  Created by Gracie on 24/09/2024.
//
//
import Foundation
import RxSwift


struct CharacterResponse: Codable {
    let results: [Character]
}

struct Character: Codable {
    let id: Int
    let name: String
    let species: String
    let status: String
    let image: String
    let gender : String
    let location : planet
}

struct CharacterData: Codable {
    let results: [Character]
    let info: PageInfo
}

struct PageInfo: Codable {
    let next: String?
    let prev: String?
}

struct planet : Codable{
    let name:String
}

