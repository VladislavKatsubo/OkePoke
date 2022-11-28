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
    private let listURL = URL(string: "https://pokeapi.co/api/v2/pokemon")
    var nextURL: URL?
    var isPaginating = false
    
    func loadPokemonList(pagination: Bool = false, completion: @escaping () -> ()) {
        if pagination {
            isPaginating = true
        }
        guard let url = (pagination ? nextURL : listURL) else { return }
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
