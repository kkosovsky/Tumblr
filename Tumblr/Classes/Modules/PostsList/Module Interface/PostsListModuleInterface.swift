//
//  PostsListModuleInterface.swift
//  Tumblr
//
//  Created by Kamil Kosowski on 15.01.2017.
//  Copyright © 2017 Kamil Kosowski. All rights reserved.
//

import Foundation
import RxSwift

protocol PostsListModuleInterface {
    
    func feedWithPosts(_ source: Source, blogName: String?) -> Observable<[Post]>
    func updateImageView(_ imagePath: String, imageView: UIImageView, forPostEntity post: Post) -> URLSessionDataTask?
    func passPostsForCache(_ posts: [Post])
    func updateDatabasePostInfo(_ isFavourite: Bool, postId id: Int)
    
}
