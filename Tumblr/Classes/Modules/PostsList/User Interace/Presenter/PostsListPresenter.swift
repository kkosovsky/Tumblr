//
//  PostsListPresenter.swift
//  Tumblr
//
//  Created by Kamil Kosowski on 15.01.2017.
//  Copyright © 2017 Kamil Kosowski. All rights reserved.
//

import Foundation
import RxSwift

class PostsListPresenter {
    
    var postsListInteractor: PostsListInteractorInput?
    
}

extension PostsListPresenter: PostsListModuleInterface {

    func feedWithPosts() -> Observable<[Post]> {
        guard let postsListInteractor = postsListInteractor else { return Observable.empty() }
        return postsListInteractor.getAllPosts()
    }
    
    func updateImageView(_ imagePath: String, imageView: UIImageView, postId: Int) -> URLSessionDataTask? {
        return postsListInteractor?.fetchImage(forImageView: imageView, withPath: imagePath, postId: postId)
    }
    
    func passPostsForCache(_ posts: [Post]) {
        postsListInteractor?.cachePosts(posts)
    }
    
}

extension PostsListPresenter: PostsListInteractorOutput {
    
    func presentData(_ databasePosts: Observable<[Post]>, apiPosts: Observable<[Post]>) -> Observable<[Post]> {
        return databasePosts.concat(apiPosts)
    }
    
}
