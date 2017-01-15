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
    
    private let blogDetailsContainer = PostsListTableViewCell.createContainerView()
    private let captionContainer = PostsListTableViewCell.createContainerView()
    
    private static func createContainerView() -> UIView {
        let container = UIView(frame: .zero)
        container.backgroundColor = UIColor.white
        return container
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setLayout()
        contentView.backgroundColor = UIColor.green
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addShadow()
    }
    
    private func addShadow() {
        let shadowPath = UIBezierPath(rect: bounds)
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        layer.shadowOpacity = 0.5
        layer.shadowPath = shadowPath.cgPath
    }

    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    private func addSubviews() {
        contentView.addSubview(blogDetailsContainer)
        contentView.addSubview(posterImageView)
        contentView.addSubview(captionContainer)
        blogDetailsContainer.addSubview(blogNameLabel)
    }
    
    private func setLayout() {
        blogDetailsContainer.snp.makeConstraints {
            $0.top.equalTo(0)
            $0.left.equalTo(0)
            $0.right.equalTo(0)
            $0.height.equalTo(50)
        }
        
        blogNameLabel.snp.makeConstraints {
            $0.top.centerXWithinMargins.equalTo(0)
            $0.top.centerYWithinMargins.equalTo(0)
        }
        
        captionContainer.snp.makeConstraints {
            $0.bottom.equalTo(0)
            $0.left.equalTo(0)
            $0.right.equalTo(0)
            $0.height.equalTo(125)
        }
        
        posterImageView.snp.makeConstraints {
            $0.top.equalTo(blogDetailsContainer.snp.bottom)
            $0.bottom.equalTo(captionContainer.snp.top)
            $0.left.equalTo(0)
            $0.right.equalTo(0)
        }
        
    }
    
    func setup(_ text: String) {
        blogNameLabel.text = text
    }
    
}
