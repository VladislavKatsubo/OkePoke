//
//  DIContainer.swift
//  OkePoke
//
//  Created by Vlad Katsubo on 7.12.22.
//

import Foundation

//MARK: DI Factory Protocols
protocol ViewControllerFactory {
    func makePokemonListViewController() -> PokemonListViewController
    func makePokemonDetailViewController(forID id: Int) -> PokemonDetailViewController
}

protocol PokemonListDependencies {
    func makePokemonListService() -> PokemonListServiceProtocol
    func makePokemonListViewModel() -> PokemonListViewModelProtocol
}

protocol PokemonDetailDependencies {
    func makePokemonDetailService() -> PokemonDetailServiceProtocol
    func makePokemonDetailViewModel(forID id: Int) -> PokemonDetailViewModelProtocol
}

protocol ImageCacheDependency {
    func makeNetworkManager() -> NetworkManager
}

//MARK: Container Class for core utility objects.
final class DependencyContainer {
    private lazy var session = URLSession(configuration: .default)
    private lazy var networkManager = NetworkManager(session: session)
}

//MARK: Conforming to our factory protocols.
extension DependencyContainer: PokemonListDependencies {
    func makePokemonListService() -> PokemonListServiceProtocol {
        PokemonListService(networkManager: self.networkManager)
    }
    
    func makePokemonListViewModel() -> PokemonListViewModelProtocol {
        PokemonListViewModel(pokemonService: self.makePokemonListService())
    }
}

extension DependencyContainer: PokemonDetailDependencies {
    func makePokemonDetailService() -> PokemonDetailServiceProtocol {
        PokemonDetailService(networkManager: self.networkManager)
    }
    
    func makePokemonDetailViewModel(forID id: Int) -> PokemonDetailViewModelProtocol {
        PokemonDetailViewModel(pokemonID: id, pokemonDetailService: self.makePokemonDetailService())
    }    
}

//MARK: Methods to create various objects where it could be needed
extension DependencyContainer: ImageCacheDependency {
    func makeNetworkManager() -> NetworkManager {
        networkManager
    }
}

extension DependencyContainer: ViewControllerFactory {
    func makePokemonListViewController() -> PokemonListViewController {
        PokemonListViewController(viewModel: makePokemonListViewModel())
    }
    
    func makePokemonDetailViewController(forID id: Int) -> PokemonDetailViewController {
        PokemonDetailViewController(viewModel: makePokemonDetailViewModel(forID: id))
    }
}
