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

class PostsListTableViewCell: UITableViewCell {
    
    private let blogDetailsContainer = PostsListTableViewCell.createContainerView()
    private let captionContainer = PostsListTableViewCell.createContainerView()
    //private var imageViewHeightConstraint: Constraint?
    
    
    fileprivate let posterImageView: UIImageView = {
        let posterImageView = UIImageView(frame: .zero)
        posterImageView.image = UIImage(named: "placeholder")
        posterImageView.isUserInteractionEnabled = true
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.clipsToBounds = true
        return posterImageView
    }()
    
    private let blogNameLabel: UILabel = {
        let blogNameLabel = UILabel(frame: .zero)
        return blogNameLabel
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
        self.backgroundColor = UIColor.blue
        selectionStyle = .none
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
        self.task?.cancel()
        self.task = nil
        posterImageView.image = UIImage(named: "placeholder")
        posterImageView.snp.updateConstraints {
            $0.height.equalTo(500)
        }
    }
    
    private func addSubviews() {
        contentView.addSubview(posterImageView)
        //addSubview(captionContainer)
        //captionContainer.addSubview(tagsLabel)
        //captionContainer.addSubview(captionLabel)
    }

    
    private func setLayout() {

        posterImageView.snp.makeConstraints {
//            $0.top.equalTo(0)
//            $0.left.equalTo(0)
//            $0.right.equalTo(0)
//            $0.bottom.equalTo(captionContainer.snp.top)
//            $0.height.equalTo(250)
            $0.edges.equalTo(0)
            $0.height.equalTo(250)
        }
        
//        posterImageView.snp.makeConstraints { (maker) in
//            maker.top.equalTo(0)
//            maker.left.equalTo(0)
//            maker.right.equalTo(0)
//            maker.bottom.equalTo(captionContainer.snp.top)
//            maker.height.equalTo(200)
//        }
        
//        tagsLabel.snp.makeConstraints {
//            $0.left.equalTo(4)
//            $0.right.equalTo(-4)
//            $0.top.equalTo(8)
//        }
//        
//        captionContainer.snp.makeConstraints {
//            $0.top.equalTo(posterImageView.snp.bottom)
//            $0.bottom.equalTo(0)
//            $0.left.equalTo(0)
//            $0.right.equalTo(0)
//            $0.height.equalTo(0)
//        }
//        
//        captionLabel.snp.makeConstraints {
//            $0.left.equalTo(4)
//            $0.right.equalTo(-4)
//            $0.top.equalTo(tagsLabel.snp.bottom).offset(8)
//            $0.bottom.equalTo(0)
//        }
        
    }
    
    func setup(withItem item: Post, eventHandler: PostsListModuleInterface?) {
        captionLabel.text = item.photoCaption?.html2String
        tagsLabel.text = item.tags?.reduce("", { (res, element) -> String in
            return res + element + ", "
        })
        if let imageData = item.smallPhoto {
            guard let image = UIImage(data: imageData) else { return }
            posterImageView.snp.updateConstraints {
                    $0.height.equalTo(image.size.height)
                }
            posterImageView.image = image
        } else {
             guard let photoPath = item.smalllPhotoPath else { print("wrong guard: ", item.type); return }
             task = eventHandler?.updateImageView(photoPath, imageView: posterImageView, forPostEntity: item)
        }
        
    }
    
}

extension String {
    var html2AttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch let error as NSError {
            print(error.localizedDescription)
            return  nil
        }
    }
    
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
    
}
