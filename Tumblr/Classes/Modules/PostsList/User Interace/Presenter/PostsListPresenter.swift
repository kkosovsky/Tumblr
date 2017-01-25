//
//  PostsListPresenter.swift
//  Tumblr
//
//  Created by Kamil Kosowski on 15.01.2017.
//  Copyright © 2017 Kamil Kosowski. All rights reserved.
//

import Foundation
import RxSwift

enum Source {
    
    case Api
    case Database
    case Both
    
}

class PostsListPresenter {
    
    var postsListInteractor: PostsListInteractorInput?
    var postsListViewController: PostsListViewController?
}

extension PostsListPresenter: PostsListModuleInterface {

    func feedWithPosts(_ source: Source, blogName: String?) -> Observable<[Post]> {
        guard let postsListInteractor = postsListInteractor else { return Observable.empty() }
        return postsListInteractor.getAllPosts(source, blogName: blogName)
    }
    
    func updateImageView(_ imagePath: String, imageView: UIImageView, forPostEntity post: Post) -> URLSessionDataTask? {
        guard let url = URL(string: imagePath) else { return nil }
        return URLSession(configuration: .ephemeral).dataTask(with: url) { [weak self] data, response, error in
            guard let imageData = data else { return }
            post.smallPhoto = imageData
            DispatchQueue.main.async {
                imageView.image = UIImage(data:imageData)
                self?.postsListInteractor?.cacheImage(imageData, post: post)
            }
        }
    }
    
    func passPostsForCache(_ posts: [Post]) {
        postsListInteractor?.cachePosts(posts)
    }
    
    func updateDatabasePostInfo(_ isFavourite: Bool, postId id: Int) {
        postsListViewController?.posts.value.first { $0.id == id }?.isFavourite = isFavourite
        postsListInteractor?.updateDatabasePostInfo(postId: id, isFavourite: isFavourite)
    }
    
}

extension PostsListPresenter: PostsListInteractorOutput {
    
    func presentData(_ databasePosts: Observable<[Post]>, apiPosts: Observable<[Post]>, source: Source) -> Observable<[Post]> {
        switch source {
            case .Api:
                return apiPosts.flatMap({ (posts) -> Observable<[Post]> in
                    return Observable.just(posts.filter { $0.type == "photo" || $0.type == "quote" })
                })
            case .Database:
                return databasePosts
            case .Both:
                return databasePosts.concat(apiPosts)
        }
        
    }
    
}
