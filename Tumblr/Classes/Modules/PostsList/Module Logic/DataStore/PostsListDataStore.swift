//
//  PostsListDataStore.swift
//  Tumblr
//
//  Created by Kamil Kosowski on 15.01.2017.
//  Copyright © 2017 Kamil Kosowski. All rights reserved.
//

import Foundation
import RxSwift

class PostsListDataStore {

    fileprivate var apiManager: ApiManager?
    
    init(_ apiManager: ApiManager) {
        self.apiManager = apiManager
    }
    
}

extension PostsListDataStore: PostsListNetworkInterface {

    func getAllPosts() -> Observable<[ApiPost]> {
        guard let apiManager = apiManager else { return Observable.empty() }
        return apiManager.requestPosts(endpoint: Endpoint.getAllPosts("thetimeandspaceblog"))
    }
    
    func fetchImage(forImageView imageView: UIImageView, withPath path: String) -> URLSessionDataTask? {
        return apiManager?.fetchImage(imageView, imagePath: path)
    }
    
}
