//
//  PokeapiResponse.swift
//  OkePoke
//
//  Created by Vlad Katsubo on 24.11.22.
//

import Foundation

// MARK: - List response
struct PokeapiResponse: Codable {
    var next: String
    var results: [PokemonList]
}

struct PokemonList: Codable {
    var name: String
    var url: String
}

// MARK: - ID response
struct PokemonIDResponse: Codable {
    var height: Int
    var sprites: Sprites
    var weight: Int
    var types: [PokemonType]
}

struct Sprites: Codable {
    
}

struct PokemonType: Codable {
    var type: [AvailableTypes]
}

struct AvailableTypes: Codable {
    var name: String
}
