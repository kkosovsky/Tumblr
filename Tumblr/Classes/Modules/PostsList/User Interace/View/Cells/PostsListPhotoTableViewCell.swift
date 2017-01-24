//
//  PostsListTableViewCell.swift
//  Tumblr
//
//  Created by Kamil Kosowski on 15.01.2017.
//  Copyright © 2017 Kamil Kosowski. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift

class PostsListPhotoTableViewCell: UITableViewCell {
    
    private let titleContainer = PostsListPhotoTableViewCell.createContainerView()
    private let captionContainer = PostsListPhotoTableViewCell.createContainerView()
    private let disposeBag = DisposeBag()
    var isFavourite = false
    
    fileprivate let posterImageView: UIImageView = {
        let posterImageView = UIImageView(frame: .zero)
        posterImageView.image = UIImage(named: "placeholder")
        posterImageView.isUserInteractionEnabled = true
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.alpha = 0.0
        posterImageView.clipsToBounds = true
        return posterImageView
    }()
    
    private let blogNameLabel: UILabel = {
        let blogNameLabel = UILabel(frame: .zero)
        return blogNameLabel
    }()
    
    let likeButton: UIButton = {
        let likeButton = UIButton(frame: .zero)
        likeButton.setImage(UIImage(named:"heart_empty"), for: .normal)
        likeButton.contentMode = .scaleAspectFit
        return likeButton
    }()
    
    private let tagsLabel: UILabel = {
        let tagsLabel = UILabel(frame: .zero)
        tagsLabel.font = UIFont.italicSystemFont(ofSize: 12)
        tagsLabel.textColor = UIColor.gray
        tagsLabel.numberOfLines = 0
        return tagsLabel
    }()
    
    private let captionLabel: UILabel = {
        let captionLabel = UILabel(frame: .zero)
        captionLabel.font = UIFont.systemFont(ofSize: 14)
        captionLabel.adjustsFontSizeToFitWidth = true
        captionLabel.numberOfLines = 0
        return captionLabel
    }()
    
    private static func createContainerView() -> UIView {
        let container = UIView(frame: .zero)
        container.backgroundColor = UIColor.white
        return container
    }
    
    var task: URLSessionDataTask? {
        didSet {
            task?.resume()
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setLayout()
        self.backgroundColor = UIColor.clear
        selectionStyle = .none
        likeButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapLikeButton)))
    }

    @objc private func didTapLikeButton() {
        isFavourite = !isFavourite
        let newImage = isFavourite ? UIImage(named: "heart_filled") : UIImage(named: "heart_empty")
        likeButton.setImage(newImage, for: .normal)
        print("Cell isFavourite changed: ", isFavourite)
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
        task?.cancel()
        task = nil
        tagsLabel.text = nil
        captionLabel.text = nil
        posterImageView.image = UIImage(named: "placeholder")
        captionContainer.backgroundColor = UIColor.white
        posterImageView.alpha = 0
    }
    
    private func addSubviews() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(captionContainer)
        captionContainer.addSubview(tagsLabel)
        captionContainer.addSubview(captionLabel)
        contentView.addSubview(titleContainer)
        titleContainer.addSubview(likeButton)
    }

    private func setLayout() {
        posterImageView.snp.makeConstraints {
            $0.top.equalTo(titleContainer.snp.bottom)
            $0.left.equalTo(0)
            $0.right.equalTo(0)
            $0.height.equalTo(450)
        }
        
        tagsLabel.snp.makeConstraints {
            $0.left.equalTo(4)
            $0.right.equalTo(likeButton.snp.left).offset( -4)
            $0.top.equalTo(8)
        }
        
        titleContainer.snp.makeConstraints {
            $0.top.equalTo(0)
            $0.bottom.equalTo(posterImageView.snp.top)
            $0.left.equalTo(0)
            $0.right.equalTo(0)
            $0.height.equalTo(50)
        }
        
        captionContainer.snp.makeConstraints {
            $0.top.equalTo(posterImageView.snp.bottom)
            $0.bottom.equalTo(0)
            $0.left.equalTo(0)
            $0.right.equalTo(0)
        }

        captionLabel.snp.makeConstraints {
            $0.left.equalTo(4)
            $0.right.equalTo(-4)
            $0.top.equalTo(tagsLabel.snp.bottom).offset(16)
            $0.bottom.equalTo(0)
        }
        
        likeButton.snp.makeConstraints {
            $0.centerYWithinMargins.equalTo(0)
            $0.right.equalTo(-4)
            $0.height.equalTo(36)
            $0.width.equalTo(36)
        }
    }
    
    func setup(withItem item: Post, eventHandler: PostsListModuleInterface?) {
        captionLabel.text = item.photoCaption?.html2String
        adjustLikeButton(withItem: item)
        adjustCaptionContainerBackgroundColor()
        fetchImage(item, eventHandler: eventHandler)
        isFavourite = item.isFavourite
        tagsLabel.text = item.tags?.reduce("", { (res, element) -> String in
            return res + element + ", "
        })
    }
    
    private func fetchImage(_ item: Post, eventHandler: PostsListModuleInterface?) {
        if let imageData = item.smallPhoto {
            guard let image = UIImage(data: imageData) else { return }
            posterImageView.image = image
        } else {
            guard let photoPath = item.smalllPhotoPath else { print("wrong guard: ", item.type); return }
            task = eventHandler?.updateImageView(photoPath, imageView: posterImageView, forPostEntity: item)
        }
        UIView.animate(withDuration: 0.35) { [weak self] in
            self?.posterImageView.alpha = 1
        }
    }
    
    private func adjustCaptionContainerBackgroundColor() {
        if captionLabel.text?.characters.count ?? 0 > 0 || tagsLabel.text?.characters.count ?? 0 > 0 {
            captionContainer.backgroundColor = UIColor.white
        } else {
            captionContainer.backgroundColor = UIColor(colorLiteralRed: 0, green: 0, blue: 0, alpha: 0)
        }
    }
    
    private func adjustLikeButton(withItem item: Post) {
        let image = item.isFavourite ? UIImage(named: "heart_filled") : UIImage(named: "heart_empty")
        likeButton.setImage(image, for: .normal)
    }
}
