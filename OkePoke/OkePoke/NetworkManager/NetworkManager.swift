//
//  NetworkManager.swift
//  OkePoke
//
//  Created by Vlad Katsubo on 24.11.22.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    let listURL = "https://pokeapi.co/api/v2/pokemon"
    
    func fetchData<T>(with url: URL, ofType: T.Type, completion: @escaping (Result<T,Error>) -> Void ) where T: Codable {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return print(error ?? "No error description") }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let data = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(data as T))
                }
            } catch let error {
                print("Error serialization json", error)
            }
        }.resume()
    }
    
    
}
//            switch T.self {
//            case is PokeapiResponse<PokemonList>.Type:
//                let pokemonData = try? decoder.decode(PokeapiResponse<PokemonList>.self, from: data)
//                DispatchQueue.main.async { completion(pokemonData as? T) }
//            default:
//                print(T.self)
//                break
//            }

//    func load<T>(url: URL, completion: @escaping (_ pokemonData: T?) -> Void) {
//        let task = URLSession.shared.dataTask(with: url) { data, _, error in
//            guard let data = data else {
//                DispatchQueue.main.async { completion(nil) }
//                return
//            }
//            let decoder = JSONDecoder()
//            decoder.keyDecodingStrategy = .convertFromSnakeCase
//            switch T.self {
//            case is PokeapiResponse<PokemonList>.Type:
//                let pokemonData = try? decoder.decode(PokeapiResponse<PokemonList>.self, from: data)
//                DispatchQueue.main.async { completion(pokemonData as? T) }
//            default:
//                print(T.self)
//                break
//            }
//        }
//        task.resume()
//    }
