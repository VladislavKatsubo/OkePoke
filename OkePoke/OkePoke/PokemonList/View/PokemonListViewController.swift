//
//  ViewController.swift
//  OkePoke
//
//  Created by Vlad Katsubo on 24.11.22.
//

import UIKit

final class PokemonListViewController: UIViewController {
    
    //MARK: - Properties
    lazy var layout: PokemonListVCLayout = .init()
    private var viewModel: PokemonListViewModelProtocol
    
    init(viewModel: PokemonListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.loadPokemonList(pagination: false) {
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


//MARK: - TableViewDelegate
extension PokemonListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
}


//MARK: - TableViewDataSource
extension PokemonListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PokemonListTableViewCell.identifier, for: indexPath) as! PokemonListTableViewCell
        cell.viewModel = viewModel.cellViewModel(at: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let container = DependencyContainer()
        let detailedVC = container.makePokemonDetailViewController(forID: indexPath.row + 1)
        navigationController?.pushViewController(detailedVC, animated: true)
    }
}


//MARK: - ScrollViewDelegate
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

