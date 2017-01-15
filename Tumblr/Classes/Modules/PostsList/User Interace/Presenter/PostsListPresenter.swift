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
    
    var postsListInteractor: PostsListInteractor?
    
}

extension PostsListPresenter: PostsListModuleInterface {

    func feedWithPosts() -> Observable<[Post]> {
        guard let postsListInteractor = postsListInteractor else { return Observable.empty() }
        return postsListInteractor.getAllPosts()
    }
    
}

extension PostsListPresenter: PostsListInteractorOutput {
    
    func showAllPosts() -> Observable<[Post]> {
        return Observable.empty()
    }
    
}
