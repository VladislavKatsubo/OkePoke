//
//  PokemonDetailVC.swift
//  OkePoke
//
//  Created by Vlad Katsubo on 27.11.22.
//

import Foundation

protocol PokemonDetailViewModelProtocol {
    var pokemonDetailedInfo: Box<PokemonInfo?> { get set }
    var imageURL: String { get }
    init(pokemonID: Int, pokemonDetailService: PokemonDetailServiceProtocol)
    func loadPokemonDetails()
}

final class PokemonDetailViewModel: PokemonDetailViewModelProtocol {
    
    private let pokemonDetailService: PokemonDetailServiceProtocol
    internal var pokemonDetailedInfo: Box<PokemonInfo?> = Box(nil)
    private let pokemonDetailURL: URL
    let pokemonID: Int
    
    var name: String {
        return "\(pokemonDetailedInfo.value?.name ?? "No data")"
    }
    
    var types: [String] {
        var names = [String]()
        pokemonDetailedInfo.value?.types.forEach({
            names.append($0.type.name)
        })
        return names
    }
    
    var weight: Int {
        return pokemonDetailedInfo.value?.weight ?? 0
    }
    
    var height: Int {
        return pokemonDetailedInfo.value?.height ?? 0
    }
    
    var imageURL: String {
        URLManager.pokemonFullDetailImageURL(forID: pokemonID).imageURL.absoluteString
    }
    
    init(pokemonID: Int, pokemonDetailService: PokemonDetailServiceProtocol) {
        self.pokemonID = pokemonID
        self.pokemonDetailService = pokemonDetailService
        self.pokemonDetailURL = URLManager.pokemonDetailInfoURL(withID: pokemonID).infoURL
    }
    
    func loadPokemonDetails() {
        pokemonDetailService.loadPokemonDetails(for: pokemonDetailURL, with: pokemonID) { [weak self] PokemonInfo in
            self?.pokemonDetailedInfo.value = PokemonInfo
        }
    }
    
}
