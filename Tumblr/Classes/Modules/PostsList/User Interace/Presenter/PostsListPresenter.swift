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
    
}

extension PostsListPresenter: PostsListModuleInterface {

    func feedWithPosts(_ source: Source, blogName: String?) -> Observable<[Post]> {
        guard let postsListInteractor = postsListInteractor else { return Observable.empty() }
        return postsListInteractor.getAllPosts(source, blogName: blogName)
    }
    
    func updateImageView(_ imagePath: String, imageView: UIImageView, forPostEntity post: Post) -> URLSessionDataTask? {
        return postsListInteractor?.cacheImage(forImageView: imageView, withPath: imagePath, forPostEntity: post)
    }
    
    func passPostsForCache(_ posts: [Post]) {
        postsListInteractor?.cachePosts(posts)
    }
    
}

extension PostsListPresenter: PostsListInteractorOutput {
    
    func presentData(_ databasePosts: Observable<[Post]>, apiPosts: Observable<[Post]>, source: Source) -> Observable<[Post]> {
        switch source {
            case .Api:
                return apiPosts.flatMap({ (posts) -> Observable<[Post]> in
                    posts.forEach { print($0.type) }
                    return Observable.just(posts)
                })
            case .Database:
                return databasePosts
            case .Both:
                return databasePosts.concat(apiPosts)
        }
        
    }
    
}
