//
//  NetworkManager.swift
//  OkePoke
//
//  Created by Vlad Katsubo on 24.11.22.
//

import Foundation

protocol NetworkManagerProtocol {
    func fetchData<T>(with url: URL, ofType: T.Type, completion: @escaping (Result<T,Error>) -> Void ) where T: Decodable
    func loadImage(url: URL, completion: @escaping (Result<Data,Error>) -> ())
    init(session: URLSession)
}

final class NetworkManager: NetworkManagerProtocol {
        
    internal var session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func fetchData<T>(with url: URL, ofType: T.Type, completion: @escaping (Result<T,Error>) -> Void ) where T: Decodable {
        session.dataTask(with: url) { data, response, error in
            guard let data = data else { return print(error ?? "No error description") }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let data = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success((data) as T))
                }
            } catch let error {
                print("Error serialization json", error)
            }
        }.resume()
    }
    
    func loadImage(url: URL, completion: @escaping (Result<Data,Error>) -> ()) {
        session.dataTask(with: url) { data, responce, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
                completion(.success(data))
            }
        }
        .resume()
    }
    
}
