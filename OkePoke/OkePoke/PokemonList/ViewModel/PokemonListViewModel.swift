//
//  PokemonListViewModel.swift
//  OkePoke
//
//  Created by Vlad Katsubo on 25.11.22.
//

import Foundation

protocol PokemonListViewModelProtocol {
    var pokemonList: Box<[PokemonData]> { get set }
    var isPaginating: Bool { get }
    init(pokemonService: PokemonListServiceProtocol)
    func numberOfRows() -> Int
    func cellViewModel(at indexPath: IndexPath) -> PokemonListTableViewCellViewModelProtocol
    func loadPokemonList(pagination: Bool)
}

final class PokemonListViewModel: PokemonListViewModelProtocol {
    private let pokemonService: PokemonListServiceProtocol
    var pokemonList: Box<[PokemonData]> = Box([])
    private let baseURL = URLManager.pokemonListURL.infoURL
    private var nextURL: URL?
    var isPaginating = false
    
    init(pokemonService: PokemonListServiceProtocol) {
        self.pokemonService = pokemonService
    }
    
    func loadPokemonList(pagination: Bool = false) {
        if pagination {
            isPaginating = true
        }
        guard let url = (pagination ? nextURL : baseURL) else { return }
        pokemonService.loadPokemonData(with: url) { [weak self] result in
            self?.nextURL = URL(string: result.next)
            self?.pokemonList.value.append(contentsOf: result.results)
            if pagination {
                self?.isPaginating = false
            }
        }
    }
    
    func numberOfRows() -> Int {
        return pokemonList.value.count
    }
    
    func cellViewModel(at indexPath: IndexPath) -> PokemonListTableViewCellViewModelProtocol {
        let pokemonData = pokemonList.value[indexPath.row]
        return PokemonListTableViewCellViewModel(pokemonData: pokemonData, pokemonID: indexPath.row + 1)
    }
    
}
