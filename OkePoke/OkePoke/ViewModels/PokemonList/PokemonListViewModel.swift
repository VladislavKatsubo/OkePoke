//
//  PokemonListViewModel.swift
//  OkePoke
//
//  Created by Vlad Katsubo on 25.11.22.
//

import Foundation

class PokemonListViewModel {
    private var pokemonService = PokemonListService()
    private var pokemonList: [PokemonData] = []
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")
    private var nextURL: URL?
    var isPaginating = false
    
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
    
    
    func cellViewModel(at indexPath: IndexPath) -> PokemonListTableViewCellViewModel? {
        let pokemonData = pokemonList[indexPath.row]
        return PokemonListTableViewCellViewModel(pokemonData: pokemonData, pokemonID: indexPath.row + 1)
    }
    
}
