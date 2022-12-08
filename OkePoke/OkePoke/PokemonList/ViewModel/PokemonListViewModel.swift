//
//  PokemonListViewModel.swift
//  OkePoke
//
//  Created by Vlad Katsubo on 25.11.22.
//

import Foundation

protocol PokemonListViewModelProtocol {
    var pokemonList: [PokemonData] { get }
    var isPaginating: Bool { get }
    func numberOfRows() -> Int
    func cellViewModel(at indexPath: IndexPath) -> PokemonListTableViewCellViewModelProtocol
    func loadPokemonList(pagination: Bool, completion: @escaping () -> ())
    init(pokemonService: PokemonListServiceProtocol)
}

final class PokemonListViewModel: PokemonListViewModelProtocol {
    private let pokemonService: PokemonListServiceProtocol
    internal var pokemonList: [PokemonData] = []
    private let baseURL = URLManager.pokemonListURL.infoURL
    private var nextURL: URL?
    var isPaginating = false
    
    init(pokemonService: PokemonListServiceProtocol) {
        self.pokemonService = pokemonService
    }
    
    func loadPokemonList(pagination: Bool = false, completion: @escaping () -> ()) {
        if pagination {
            isPaginating = true
        }
        guard let url = (pagination ? nextURL : baseURL) else { return }
        pokemonService.loadPokemonData(with: url) { [weak self] result in
            self?.nextURL = URL(string: result.next)
            self?.pokemonList.append(contentsOf: result.results)
            completion()
            if pagination {
                self?.isPaginating = false
            }
        }
    }
    
    func numberOfRows() -> Int {
        return pokemonList.count
    }
    
    
    func cellViewModel(at indexPath: IndexPath) -> PokemonListTableViewCellViewModelProtocol {
        let pokemonData = pokemonList[indexPath.row]
        return PokemonListTableViewCellViewModel(pokemonData: pokemonData, pokemonID: indexPath.row + 1)
    }
    
}
