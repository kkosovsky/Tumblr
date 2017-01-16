//
//  PostsListInteractorIO.swift
//  Tumblr
//
//  Created by Kamil Kosowski on 15.01.2017.
//  Copyright © 2017 Kamil Kosowski. All rights reserved.
//

import Foundation
import RxSwift

protocol PostsListInteractorInput {

    func getAllPosts() -> Observable<[Post]>
    func fetchImage(forImageView imageView: UIImageView, withPath path: String, postId: Int) -> URLSessionDataTask?
    func cachePosts(_ posts: [Post])
    
}


protocol PostsListInteractorOutput {
    
    func presentData(_ databasePosts: Observable<[Post]>, apiPosts: Observable<[Post]>) -> Observable<[Post]>
    
}
