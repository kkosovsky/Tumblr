//
//  FavouritesDataStore.swift
//  Tumblr
//
//  Created by Kamil Kosowski on 24.01.2017.
//  Copyright © 2017 Kamil Kosowski. All rights reserved.
//

import Foundation
import RxSwift

class FavouritesDataStore {
    
    fileprivate var databaseManager: DatabaseManager?
    
    init(_ databaseManager: DatabaseManager) {
        self.databaseManager = databaseManager
    }
    
}

extension FavouritesDataStore: FavouritesDatabaseInterface {
    
    func fetchAllPosts() -> Observable<[DatabasePost]> {
        guard let databaseManager = databaseManager else { return Observable.empty() }
        return databaseManager.fetchAll()
    }
}
