//
//  QuoteTableViewCell.swift
//  Tumblr
//
//  Created by Kamil Kosowski on 25.01.2017.
//  Copyright © 2017 Kamil Kosowski. All rights reserved.
//

import UIKit
import SnapKit

class QuoteTableViewCell: UITableViewCell, Settable {

    private let quoteLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.italicSystemFont(ofSize: 26)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        selectionStyle = .none
        addSubviews()
        setLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        contentView.addSubview(quoteLabel)
    }
    
    private func setLayout() {
        quoteLabel.snp.makeConstraints {
            $0.top.left.equalTo(8)
            $0.bottom.right.equalTo(-8)
        }
    }
    
    func setup(withItem item: Post, eventHandler: PostsListModuleInterface?) {
        quoteLabel.text = item.quoteText
    }
}

