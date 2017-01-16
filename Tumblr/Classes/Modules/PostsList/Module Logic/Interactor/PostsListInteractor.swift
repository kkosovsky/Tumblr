//
//  PostsListInteractor.swift
//  Tumblr
//
//  Created by Kamil Kosowski on 15.01.2017.
//  Copyright © 2017 Kamil Kosowski. All rights reserved.
//

import Foundation
import RxSwift

class PostsListInteractor {
    
    var postInteractorOutput: PostsListInteractorOutput?
    var dataStore: PostsListDataStore?
    var disposeBag = DisposeBag()
   
    init(_ interactorOutput: PostsListInteractorOutput, dataStore: PostsListDataStore) {
        self.postInteractorOutput = interactorOutput
        self.dataStore = dataStore
    }
    
    fileprivate func plainPostsFromApiPosts(_ apiPosts: [ApiPost]) -> Observable<[Post]> {
        let posts = apiPosts.flatMap { Post($0) }
        return Observable.just(posts)
    }
    
    fileprivate func databasePostsFromPlainPosts(_ posts: [Post]) -> [DatabasePost] {
        return posts.flatMap { (post) -> DatabasePost? in
            let databasePost = DatabasePost()
            databasePost.setUp(withPlainObjectModel: post)
            return databasePost
        }
    }
    
}

extension PostsListInteractor: PostsListInteractorInput {

    func getAllPosts() -> Observable<[Post]> {
        guard let dataStore = dataStore else { return Observable.empty() }
        return dataStore.getAllPosts().flatMap { self.plainPostsFromApiPosts($0) }
    }
    
    func fetchImage(forImageView imageView: UIImageView, withPath path: String, postId: Int) -> URLSessionDataTask? {
        return dataStore?.fetchImage(forImageView: imageView, withPath: path, postId: postId)
    }
    
    func cachePosts(_ posts: [Post]) {
        dataStore?.cachePostsData(databasePostsFromPlainPosts(posts))
    }
    
}
