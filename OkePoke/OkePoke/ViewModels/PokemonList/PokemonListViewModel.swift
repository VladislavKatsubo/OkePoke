//
//  PokemonListViewModel.swift
//  OkePoke
//
//  Created by Vlad Katsubo on 25.11.22.
//

import Foundation

//protocol PokemonListViewModelProtocol {
//    var pokemonList: PokeapiResponse? { get }
//    var pokemonArray: [String] { get set }
//    func loadPokemonList(completion: @escaping () -> ())
//    func numberOfRows() -> Int
//}

class PokemonListViewModel {
    private var pokemonService = PokemonListService()
    var pokemonList: [PokemonData] = []
    
    func loadPokemonList(completion: @escaping () -> ()) {
        pokemonService.loadPokemonData { [weak self] result in
            self?.pokemonList = result.results
            completion()
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
