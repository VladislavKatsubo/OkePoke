//
//  PokemonListService.swift
//  OkePoke
//
//  Created by Vlad Katsubo on 25.11.22.
//

import Foundation

struct PokemonListService {
        
    func loadPokemonData(with url: URL, completion: @escaping (PokeapiResponse) -> ()) {
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
