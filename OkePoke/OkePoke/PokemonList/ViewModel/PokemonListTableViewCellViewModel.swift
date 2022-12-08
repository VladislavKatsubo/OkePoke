//
//  PokemonListTableViewCellMode.swift
//  OkePoke
//
//  Created by Vlad Katsubo on 26.11.22.
//

import Foundation

protocol PokemonListTableViewCellViewModelProtocol {
    var pokemonName: String { get }
    var pokemonImage: String { get }
    init(pokemonData: PokemonData, pokemonID: Int)
}

final class PokemonListTableViewCellViewModel: PokemonListTableViewCellViewModelProtocol {
    
    private let pokemonData: PokemonData
    private let pokemonID: Int
    private let pokemonImageURL: URL
    
    var pokemonName: String {
        return pokemonData.name
    }
    
    var pokemonImage: String {
        pokemonImageURL.absoluteString
    }
        
    required init(pokemonData: PokemonData, pokemonID: Int) {
        self.pokemonData = pokemonData
        self.pokemonID = pokemonID
        self.pokemonImageURL = URLManager.pokemonListImageURL(forID: pokemonID).imageURL
    }
    
}
