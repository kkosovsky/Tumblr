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
    
}

extension PostsListInteractor: PostsListInteractorInput {

    func getAllPosts() -> Observable<[Post]> {
        return Observable.empty()
    }
    
}
