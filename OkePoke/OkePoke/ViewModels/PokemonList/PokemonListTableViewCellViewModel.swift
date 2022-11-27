//
//  PokemonListTableViewCellMode.swift
//  OkePoke
//
//  Created by Vlad Katsubo on 26.11.22.
//

import Foundation

//protocol PokemonListTableViewCellViewModelProtocol {
//
//}

class PokemonListTableViewCellViewModel {
    
    private let pokemonData: PokemonData
    private let pokemonID: Int
    
    var pokemonName: String {
        return pokemonData.name
    }
    
    var pokemonImage: String {
        return String("https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(pokemonID).png")
    }
        
    required init(pokemonData: PokemonData, pokemonID: Int) {
        self.pokemonData = pokemonData
        self.pokemonID = pokemonID
    }
}
