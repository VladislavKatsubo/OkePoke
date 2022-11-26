//
//  PokemonListVCLayout.swift
//  OkePoke
//
//  Created by Vlad Katsubo on 25.11.22.
//

import UIKit

class PokemonListVCLayout: UIView {
    let tableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureTableView() {
        addSubview(tableView)
        tableView.pin(to: self)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.rowHeight = 50
    }
}
