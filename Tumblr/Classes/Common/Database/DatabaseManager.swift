//
//  DatabaseManager.swift
//  Tumblr
//
//  Created by Kamil Kosowski on 15.01.2017.
//  Copyright © 2017 Kamil Kosowski. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift


class DatabaseManager {
    
    let realm = try! Realm()
    
    func clearDatabase() {
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    func cacheImage(_ data: Data, withId id: Int) {
        
    }
    
    func cachePosts(_ posts: [DatabasePost]) {
       posts.forEach { addToDatabase($0) }
    }
    
    private func addToDatabase(_ post: DatabasePost) {
        if containsPost(withId: post.id) {
            return
        } else {
            try! realm.write {
                realm.add(post)
            }
        }
    }
    
    private func containsPost(withId id: Int) -> Bool {
        let posts = realm.objects(DatabasePost.self)
        let resultsWithId = posts.filter("id == %@", id)
        return resultsWithId.count > 0
    }
    
}
