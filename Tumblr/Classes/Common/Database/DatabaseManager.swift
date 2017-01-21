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
        let post = realm.objects(DatabasePost.self).filter("id == %@", id).first
        guard post?.smallPhoto == nil else { return }
            try! realm.write {
                post?.smallPhoto = data
        }
    }
    
    func printAllPosts() {
        print(realm.objects(DatabasePost.self).count)
    }
    
    func cachePosts(_ posts: [DatabasePost]) {
       posts.forEach { addToDatabase($0) }
    }
    
    func fetchAll() -> Observable<[DatabasePost]> {
        return Observable.just(Array(realm.objects(DatabasePost.self)))
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

func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
    UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
    image.draw(in: CGRect(origin: CGPoint.zero, size: CGSize(width: newSize.width, height: newSize.height)))
    let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    return newImage
}
