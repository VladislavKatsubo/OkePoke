//
//  PokemonListTableViewCellMode.swift
//  OkePoke
//
//  Created by Vlad Katsubo on 26.11.22.
//

import Foundation

protocol PokemonListTableViewCellViewModelProtocol {
    
}

class PokemonListTableViewCellViewModel: PokemonListTableViewCellViewModelProtocol {
    
    private let pokemonInfo: PokemonList
    
    var pokemonName: String {
        return pokemonInfo.name
    }
        
    required init(pokemonInfo: PokemonList) {
        self.pokemonInfo = pokemonInfo
    }
}
