//
//  ViewController.swift
//  OkePoke
//
//  Created by Vlad Katsubo on 24.11.22.
//

import UIKit

class PokemonListViewController: UIViewController {
    
    lazy var layout: PokemonListVCLayout = .init()
    
    private var viewModel = PokemonListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loadPokemonList {
                self.layout.tableView.reloadData()
        }
        
        layout.tableView.delegate = self
        layout.tableView.dataSource = self
    }
    
    override func loadView() {
        super.loadView()
        view = layout
    }
    
}

extension PokemonListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailedVC = PokemonDetailViewController()
        detailedVC.pokemonDetailViewModel = PokemonDetailViewModel(pokemonID: indexPath.row + 1)
        navigationController?.pushViewController(detailedVC, animated: true)
    }
}

extension PokemonListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PokemonListTableViewCell.identifier, for: indexPath) as! PokemonListTableViewCell
        cell.viewModel = viewModel.cellViewModel(at: indexPath)
        return cell
    }
    
}

extension PokemonListViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        layout.checkScroll(for: scrollView) {
            guard !viewModel.isPaginating else { return }
            layout.setSpinnerFooter()
            viewModel.loadPokemonList(pagination: true) {
                self.layout.tableView.reloadData()
                self.layout.tableView.tableFooterView = .none
            }
        }
        
        
        
    }
}

