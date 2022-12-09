//
//  PokeapiResponse.swift
//  OkePoke
//
//  Created by Vlad Katsubo on 24.11.22.
//

import Foundation

// MARK: - List response
struct PokeapiResponse: Decodable {
    let next: String
    let results: [PokemonData]
}

struct PokemonData: Decodable {
    let name: String
    let url: String
}


// MARK: - ID response
struct PokemonInfo: Decodable {
    let id: Int
    let name: String
    let height: Int
    let sprites: Sprites
    let weight: Int
    let types: [PokemonType]
}
extension PokemonInfo {
    struct Sprites: Decodable {
        let frontDefault: String
    }
    struct PokemonType: Decodable {
        let type: AvailableTypes
    }
}

struct AvailableTypes: Decodable {
    let name: String
}
