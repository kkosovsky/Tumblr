//
//  PostsListDataStore.swift
//  Tumblr
//
//  Created by Kamil Kosowski on 15.01.2017.
//  Copyright © 2017 Kamil Kosowski. All rights reserved.
//

import Foundation
import RxSwift

enum FetchSource {
    
    case Api
    case Database
    case Both
    
}


class PostsListDataStore {

    fileprivate var apiManager: ApiManager?
    fileprivate var databaseManager: DatabaseManager?
    
    init(_ apiManager: ApiManager, databaseManager: DatabaseManager) {
        self.apiManager = apiManager
        self.databaseManager = databaseManager
    }
    
}

extension PostsListDataStore: PostsListNetworkInterface {

    func getAllPosts() -> Observable<[ApiPost]> {
        guard let apiManager = apiManager else { return Observable.empty() }
        return apiManager.requestPosts(endpoint: Endpoint.getAllPosts("thetimeandspaceblog"))
    }
    
    func cacheImage(forImageView imageView: UIImageView, withPath path: String, forPostEntity post: Post) -> URLSessionDataTask? {
        return apiManager?.fetchImage(imageView, imagePath: path) { [weak self] data in
            self?.databaseManager?.cacheImage(data, withId: post.id)
        }
    }
    
}

extension PostsListDataStore: PostsListDatabaseInterface {
    
    func cachePostsData(_ posts: [DatabasePost]) {
        databaseManager?.cachePosts(posts)
    }
    
    func fetchAllPosts() -> Observable<[DatabasePost]> {
        guard let databaseManager = databaseManager else { return Observable.empty() }
        return databaseManager.fetchAll()
    }
    
}
