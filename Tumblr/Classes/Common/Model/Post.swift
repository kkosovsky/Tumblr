//
//  Post.swift
//  Tumblr
//
//  Created by Kamil Kosowski on 15.01.2017.
//  Copyright © 2017 Kamil Kosowski. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class Post {

    var id: Int
    var url: String
    var type: String
    var date: String
    var largePhotoPath: String?
    var largePhoto: Data?
    var smalllPhotoPath: String?
    var smallPhoto: Data?
    var photoCaption: String?
    var tags: [String]?
    var isFavourite = false
    var quoteText: String?
    
    init(_ apiPost: ApiPost) {
        id = Post.idFromApiPost(apiPost.id)
        url = apiPost.url
        type = apiPost.type
        date = apiPost.date
        largePhotoPath = findLargePhotoPath(apiPost)
        smalllPhotoPath = findThumbnailPhotoPath(apiPost)
        photoCaption = apiPost.photoCaption
        tags = apiPost.tags
        quoteText = apiPost.quoteText
    }
    
    init(_ databasePost: DatabasePost) {
        id = databasePost.id
        url = databasePost.url
        type = databasePost.type
        date = databasePost.date
        largePhotoPath = databasePost.largePhotoPath
        smalllPhotoPath = databasePost.smallPhotoPath
        smallPhoto = databasePost.smallPhoto
        largePhoto = databasePost.largePhoto
        photoCaption = databasePost.photoCaption
        isFavourite = databasePost.isFavourite
        tags = databasePost.tags.map{ $0.tagName }
        quoteText = databasePost.quoteText
    }
    
    private func findLargePhotoPath(_ apiPost: ApiPost) -> String? {
        let photoPath = apiPost.photo1280 != nil ? apiPost.photo1280 : apiPost.photo500 != nil ? apiPost.photo500 : nil
        return photoPath
    }
    
    private func findThumbnailPhotoPath(_ apiPost: ApiPost) -> String? {
        let photoPath = apiPost.photo400 != nil ? apiPost.photo400 : nil
        return photoPath
    }
    
    private static func idFromApiPost(_ apiPostId: String) -> Int {
        if let id = Int(apiPostId) {
            return id
        } else {
            return Int(arc4random())
        }
    }
    
}

extension Post: Hashable {
    
    var hashValue: Int {
        get {
            return self.id.hashValue
        }
    }
    
    public static func ==(lhs: Post, rhs: Post) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
}

extension Post: ReactiveCompatible {}

extension Reactive where Base: Post {
    
    var imageObserver: AnyObserver<()>{
        return AnyObserver{ [weak base] in
            guard case .next = $0 else { return }
            guard let unwrappedBase = base else { return }
            base?.isFavourite = !unwrappedBase.isFavourite
        }
    }
    
    var isFavouriteObservable: Observable<Bool> {
        return Observable.just(base.isFavourite)
    }
    
}
