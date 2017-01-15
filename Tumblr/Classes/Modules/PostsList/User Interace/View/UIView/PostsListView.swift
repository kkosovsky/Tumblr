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
        backgroundColor = .TumblrBackground()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let postsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .TumblrBackground()
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    private func addSubviews() {
        addSubview(postsTableView)
    }
    
    private func setupLayout() {
        postsTableView.snp.makeConstraints {
            $0.top.equalTo(0)
            $0.left.equalTo(16)
            $0.right.equalTo(-16)
            $0.bottom.equalTo(0)
        }
    }

}
