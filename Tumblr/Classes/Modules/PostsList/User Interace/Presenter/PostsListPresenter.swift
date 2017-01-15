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
    
    func updateImageView(_ imagePath: String, imageView: UIImageView) -> URLSessionDataTask? {
        guard let url = URL(string: imagePath) else { return nil }
        return URLSession(configuration: .ephemeral).dataTask(with: url) { [weak self] data, response, error in
            guard let myData = data else { return }
           
            DispatchQueue.main.async {
                imageView.image = UIImage(data:myData)
                //self?.userListInteractor?.cacheImage(myData, id: user.email.hashValue)
            }
        }
    }
    
}

extension PostsListPresenter: PostsListInteractorOutput {
    
    func showAllPosts() -> Observable<[Post]> {
        return Observable.empty()
    }
    
}
