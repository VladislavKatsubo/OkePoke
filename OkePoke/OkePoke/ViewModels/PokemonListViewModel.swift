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
    var pokemonList: [PokemonList] = []
    
    func loadPokemonList(completion: @escaping () -> ()) {
        pokemonService.loadPokemons { [weak self] result in
                result.results.forEach({ self?.pokemonList.append($0) })
                completion()
        }
    }
    
    func numberOfRows() -> Int {
        return pokemonList.count
    }
    
    func cellViewModel(at indexPath: IndexPath) -> PokemonListTableViewCellViewModelProtocol {
        return PokemonListTableViewCellViewModel(pokemonInfo: pokemonList[indexPath.row])
    }
    
    
}
