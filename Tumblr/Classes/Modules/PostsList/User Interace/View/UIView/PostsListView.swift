//
//  PostsListView.swift
//  Tumblr
//
//  Created by Kamil Kosowski on 11.01.2017.
//  Copyright © 2017 Kamil Kosowski. All rights reserved.
//

import UIKit
import SnapKit

class PostsListView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addSubviews()
        setupLayout()
        backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let userTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    private func addSubviews() {
        addSubview(userTableView)
    }
    
    private func setupLayout() {
        userTableView.snp.makeConstraints {
            $0.edges.equalTo(0)
        }
    }

}
