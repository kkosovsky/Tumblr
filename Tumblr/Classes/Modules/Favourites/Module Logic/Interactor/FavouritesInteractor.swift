//
//  FavouritesInteractor.swift
//  Tumblr
//
//  Created by Kamil Kosowski on 24.01.2017.
//  Copyright © 2017 Kamil Kosowski. All rights reserved.
//

import Foundation
import RxSwift

class FavouritesInteractor {
    
    var postInteractorOutput: FavouritesInteractorOutput?
    var dataStore: FavouritesDataStore?
    var disposeBag = DisposeBag()
    
    init(_ interactorOutput: FavouritesInteractorOutput, dataStore: FavouritesDataStore) {
        self.postInteractorOutput = interactorOutput
        self.dataStore = dataStore
    }
    
    fileprivate func plainPostsFromDatabasePosts(_ databasePosts: [DatabasePost]) -> Observable<[Post]> {
        let posts = databasePosts.flatMap { Post($0) }
        
        return Observable.just(posts.filter { $0.isFavourite == true })
    }

}

extension FavouritesInteractor: FavouritesInteractorInput {
    
    func fetchFavouritePosts(source: Source) -> Observable<[Post]> {
        guard let dataStore = dataStore, let interactorOutput = postInteractorOutput else { return Observable.empty() }
        let databasePosts = dataStore.fetchAllPosts().flatMap { self.plainPostsFromDatabasePosts($0) }
        
        return interactorOutput.presentData(databasePosts)
    }
    
}
