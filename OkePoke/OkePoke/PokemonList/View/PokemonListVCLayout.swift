//
//  PokemonListVCLayout.swift
//  OkePoke
//
//  Created by Vlad Katsubo on 25.11.22.
//

import UIKit

final class PokemonListVCLayout: UIView {
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureTableView() {
        addSubview(tableView)
        tableView.pin(to: self)
        tableView.register(PokemonListTableViewCell.self, forCellReuseIdentifier: PokemonListTableViewCell.identifier)
        tableView.rowHeight = 100
        tableView.separatorStyle = .none
    }
    
    
    //MARK: - Pagination methods
    func checkScroll(for scrollView: UIScrollView, completion: () -> ()) {
        let position = scrollView.contentOffset.y
        
        if position > (tableView.contentSize.height - scrollView.frame.size.height + 100) && tableView.contentSize.height > 500 {
            completion()
        }
    }
    
    func setSpinnerFooter() {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: 100))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        tableView.tableFooterView = footerView
    }
}
