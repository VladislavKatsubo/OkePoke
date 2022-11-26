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
        viewModel = PokemonListViewModel()
        
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
    
}

extension PokemonListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = viewModel.pokemonList[indexPath.row].name
        return cell
    }
    
    
}

