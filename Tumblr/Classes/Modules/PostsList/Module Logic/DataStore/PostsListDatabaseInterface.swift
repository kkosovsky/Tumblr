//
//  PostsListDatabaseInterface.swift
//  Tumblr
//
//  Created by Kamil Kosowski on 15.01.2017.
//  Copyright © 2017 Kamil Kosowski. All rights reserved.
//

import Foundation
import RxSwift

protocol PostsListDatabaseInterface {

    func cachePostsData(_ posts: [DatabasePost])
    func fetchAllPosts() -> Observable<[DatabasePost]>
    func setPostFavourite(postId id: Int, isFavourite: Bool)
    
}
