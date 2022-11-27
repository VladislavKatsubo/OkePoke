//
//  PokemonDetailVC.swift
//  OkePoke
//
//  Created by Vlad Katsubo on 27.11.22.
//

import Foundation


class PokemonDetailViewModel {
    
    private var pokemonDetailService = PokemonDetailService()
    var pokemonDetailedInfo: PokemonInfo?
    private let pokemonID: Int
    
    var name: String {
        return "\(pokemonDetailedInfo?.name ?? "No data")"
    }
    
    var types: String {
        return "\(String(describing: pokemonDetailedInfo?.types))"
    }
    
    var weight: Int {
        return pokemonDetailedInfo?.weight ?? 0
    }
    
    var height: Int {
        return pokemonDetailedInfo?.height ?? 0
    }
    
    var imageURL: String {
        return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/\(pokemonID).png"
    }
    
    var downloadedPokemon: (() -> ())?
    
    func loadPokemonDetails() {
        pokemonDetailService.loadPokemonDetails(with: pokemonID) { [weak self] PokemonInfo in
            self?.pokemonDetailedInfo = PokemonInfo
            self?.downloadedPokemon?()
        }
    }
    
    init(pokemonID: Int) {
        self.pokemonID = pokemonID
    }
    
}
