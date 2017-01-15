//
//  PostsListTableViewCell.swift
//  Tumblr
//
//  Created by Kamil Kosowski on 15.01.2017.
//  Copyright © 2017 Kamil Kosowski. All rights reserved.
//

import UIKit
import SnapKit

class PostsListTableViewCell: UITableViewCell {
    
    private let posterImageView: UIImageView = {
        let posterImageView = UIImageView(frame: .zero)
        posterImageView.image = UIImage(named: "Blur_placeholder")
        posterImageView.isUserInteractionEnabled = true
        posterImageView.contentMode = .scaleAspectFill
        return posterImageView
    }()
    
    private let blogNameLabel: UILabel = {
        let blogNameLabel = UILabel(frame: .zero)
        return blogNameLabel
    }()
    
    private let blogNameBackground: UIView = {
        return UIView(frame: .zero)
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setLayout()
        contentView.backgroundColor = UIColor.green
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    private func addSubviews() {
        contentView.addSubview(blogNameLabel)
    }
    
    private func setLayout() {
        blogNameLabel.snp.makeConstraints {
            $0.centerXWithinMargins.equalTo(0)
            $0.centerYWithinMargins.equalTo(0)
        }
    }
    
    func setup(_ text: String) {
        blogNameLabel.text = text
    }
    
}
