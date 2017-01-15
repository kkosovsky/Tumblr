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
    var dataStore: PostsListDataStore?
    
    init(_ interactorOutput: PostsListInteractorOutput, dataStore: PostsListDataStore) {
        self.postInteractorOutput = interactorOutput
        self.dataStore = dataStore
    }
}

extension PostsListInteractor: PostsListInteractorInput {

    func getAllPosts() -> Observable<[Post]> {
        guard let dataStore = dataStore else { return Observable.empty() }
        return dataStore.getAllPosts()
    }
    
}
