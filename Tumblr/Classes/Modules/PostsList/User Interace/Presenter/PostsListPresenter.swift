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

    func feedWithPosts() -> Observable<[ApiPost]> {
        guard let postsListInteractor = postsListInteractor else { return Observable.empty() }
        return postsListInteractor.getAllPosts()
    }
    
    func updateImageView(_ imagePath: String, imageView: UIImageView) -> URLSessionDataTask? {
       return postsListInteractor?.fetchImage(forImageView: imageView, withPath: imagePath)
    }
    
}

extension PostsListPresenter: PostsListInteractorOutput {
    
    func showAllPosts() -> Observable<[ApiPost]> {
        return Observable.empty()
    }
    
}
