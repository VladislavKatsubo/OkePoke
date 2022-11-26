//
//  PokemonListService.swift
//  OkePoke
//
//  Created by Vlad Katsubo on 25.11.22.
//

import Foundation

struct PokemonListService {
    
    private let listURL = URL(string: "https://pokeapi.co/api/v2/pokemon")
    
        
    func loadPokemons(completion: @escaping (PokeapiResponse) -> ()) {
        guard let url = listURL else { return }
        NetworkManager.shared.fetchData(with: url, ofType: PokeapiResponse.self) { result in
            switch result {
            case .success(let data):
                completion(data)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
