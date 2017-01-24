//
//  FavouritesTableViewCell.swift
//  Tumblr
//
//  Created by Kamil Kosowski on 24.01.2017.
//  Copyright © 2017 Kamil Kosowski. All rights reserved.
//

import UIKit

class FavouritesPhotoTableViewCell: UITableViewCell {

    private let captionContainer = PostsListPhotoTableViewCell.createContainerView()
    
    let photoImageView: UIImageView = {
        let photoImageView = UIImageView(frame: .zero)
        photoImageView.image = UIImage(named: "placeholder")
        photoImageView.isUserInteractionEnabled = true
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.alpha = 0
        photoImageView.clipsToBounds = true
        return photoImageView
    }()
    
    private let blogNameLabel: UILabel = {
        let blogNameLabel = UILabel(frame: .zero)
        return blogNameLabel
    }()
    
    private let captionLabel: UILabel = {
        let captionLabel = UILabel(frame: .zero)
        captionLabel.font = UIFont.systemFont(ofSize: 14)
        captionLabel.adjustsFontSizeToFitWidth = true
        captionLabel.numberOfLines = 0
        return captionLabel
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setLayout()
        self.backgroundColor = UIColor.clear
        selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addShadow()
    }
    
    func setup(withItem item: Post) {
        guard let imageData = item.smallPhoto else { print("No image data"); return }
        photoImageView.image = UIImage(data: imageData)
        captionLabel.text = item.photoCaption
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
        captionLabel.text = nil
        photoImageView.image = UIImage(named: "placeholder")
        captionContainer.backgroundColor = UIColor.white
        photoImageView.alpha = 0
    }
    
    private func addSubviews() {
        contentView.addSubview(photoImageView)
        //contentView.addSubview(captionContainer)
        //captionContainer.addSubview(captionLabel)
    }
    
    private func setLayout() {
        photoImageView.snp.makeConstraints {
            $0.top.equalTo(0)
            $0.left.equalTo(0)
            $0.right.equalTo(0)
            $0.bottom.equalTo(0)
            $0.height.equalTo(450)
        }
        
//        captionContainer.snp.makeConstraints {
//            $0.top.equalTo(photoImageView.snp.bottom)
//            $0.bottom.equalTo(0)
//            $0.left.equalTo(0)
//            $0.right.equalTo(0)
//        }
//        
//        captionLabel.snp.makeConstraints {
//            $0.left.equalTo(4)
//            $0.right.equalTo(-4)
//            $0.top.equalTo(0)
//            $0.bottom.equalTo(0)
//        }
//        
    }

}
