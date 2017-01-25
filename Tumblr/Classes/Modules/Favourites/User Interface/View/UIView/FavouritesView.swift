//
//  FavouritesView.swift
//  Tumblr
//
//  Created by Kamil Kosowski on 24.01.2017.
//  Copyright © 2017 Kamil Kosowski. All rights reserved.
//

import UIKit

class FavouritesView: UIView {

    override init(frame: CGRect) {
        super.init(frame: .zero)
        addSubviews()
        setupLayout()
        backgroundColor = .TumblrBackground()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let favouritesTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .TumblrBackground()
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    private func addSubviews() {
        addSubview(favouritesTableView)
    }
    
    private func setupLayout() {
        favouritesTableView.snp.makeConstraints {
            $0.top.equalTo(0)
            $0.left.equalTo(16)
            $0.right.equalTo(-16)
            $0.bottom.equalTo(0)
        }
    }

}
