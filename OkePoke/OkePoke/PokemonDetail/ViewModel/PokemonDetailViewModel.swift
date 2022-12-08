//
//  PokemonDetailVC.swift
//  OkePoke
//
//  Created by Vlad Katsubo on 27.11.22.
//

import Foundation

protocol PokemonDetailViewModelProtocol {
    var pokemonID: Int { get }
    var name: String { get }
    var types: [String] { get }
    var weight: Int { get }
    var height: Int { get }
    var imageURL: String { get }
    var downloadedPokemon: (()->())? { get set }
    func loadPokemonDetails()
    init(pokemonID: Int, pokemonDetailService: PokemonDetailServiceProtocol)
}

final class PokemonDetailViewModel: PokemonDetailViewModelProtocol {
    
    private let pokemonDetailService: PokemonDetailServiceProtocol
    private var pokemonDetailedInfo: PokemonInfo?
    private let pokemonDetailURL: URL
    let pokemonID: Int
    
    var name: String {
        return "\(pokemonDetailedInfo?.name ?? "No data")"
    }
    
    var types: [String] {
        var names = [String]()
        pokemonDetailedInfo?.types.forEach({
            names.append($0.type.name)
        })
        return names
    }
    
    var weight: Int {
        return pokemonDetailedInfo?.weight ?? 0
    }
    
    var height: Int {
        return pokemonDetailedInfo?.height ?? 0
    }
    
    var imageURL: String {
        URLManager.pokemonFullDetailImageURL(forID: pokemonID).imageURL.absoluteString
    }
    
    var downloadedPokemon: (() -> ())?
    
    init(pokemonID: Int, pokemonDetailService: PokemonDetailServiceProtocol) {
        self.pokemonID = pokemonID
        self.pokemonDetailService = pokemonDetailService
        self.pokemonDetailURL = URLManager.pokemonDetailInfoURL(withID: pokemonID).infoURL
    }
    
    func loadPokemonDetails() {
        pokemonDetailService.loadPokemonDetails(for: pokemonDetailURL, with: pokemonID) { [weak self] PokemonInfo in
            self?.pokemonDetailedInfo = PokemonInfo
            self?.downloadedPokemon?()
        }
    }
    
}
