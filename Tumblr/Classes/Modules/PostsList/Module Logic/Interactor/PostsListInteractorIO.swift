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

    func getAllPosts(_ source: Source, blogName: String?) -> Observable<[Post]>
    func cacheImage(forImageView imageView: UIImageView, withPath path: String, forPostEntity post: Post) -> URLSessionDataTask?
    func cachePosts(_ posts: [Post])
    func updateDatabasePostInfo(postId id: Int, isFavourite: Bool)
    
}


protocol PostsListInteractorOutput {
    
    func presentData(_ databasePosts: Observable<[Post]>, apiPosts: Observable<[Post]>, source: Source) -> Observable<[Post]>
    
}
