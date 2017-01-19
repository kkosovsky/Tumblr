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
    
    fileprivate func plainPostsFromDatabasePosts(_ databasePosts: [DatabasePost]) -> Observable<[Post]> {
        let posts = databasePosts.flatMap { Post($0) }
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

    func getAllPosts(_ source: Source, blogName: String?) -> Observable<[Post]> {
        guard let dataStore = dataStore, let postInteractorOutput = postInteractorOutput else { return Observable.empty() }
        let apiPosts = dataStore.getAllPosts(blogName).flatMap { self.plainPostsFromApiPosts($0) }
        let databasePosts = dataStore.fetchAllPosts().flatMap { self.plainPostsFromDatabasePosts($0) }
        return postInteractorOutput.presentData(databasePosts, apiPosts: apiPosts, source: source)
    }
    
    func cacheImage(forImageView imageView: UIImageView, withPath path: String, forPostEntity post: Post) -> URLSessionDataTask? {
        return dataStore?.cacheImage(forImageView: imageView, withPath: path, forPostEntity: post)
    }
    
    func cachePosts(_ posts: [Post]) {
        dataStore?.cachePostsData(databasePostsFromPlainPosts(posts))
    }
    
}
