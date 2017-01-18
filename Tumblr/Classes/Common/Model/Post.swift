//
//  Post.swift
//  Tumblr
//
//  Created by Kamil Kosowski on 15.01.2017.
//  Copyright © 2017 Kamil Kosowski. All rights reserved.
//

import Foundation

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
    
    init(_ apiPost: ApiPost) {
        id = Post.idFromApiPost(apiPost.id)
        url = apiPost.url
        type = apiPost.type
        date = apiPost.date
        largePhotoPath = findLargePhotoPath(apiPost)
        smalllPhotoPath = findThumbnailPhotoPath(apiPost)
        photoCaption = apiPost.photoCaption
        tags = apiPost.tags
    }
    
    init(_ databasePost: DatabasePost) {
        id = databasePost.id
        url = databasePost.url
        type = databasePost.type
        date = databasePost.date
        largePhotoPath = databasePost.largePhotoPath
        smalllPhotoPath = databasePost.smallPhotoPath
        photoCaption = databasePost.photoCaption
        tags = databasePost.tags.map{ $0.tagName }
    }
    
    private func findLargePhotoPath(_ apiPost: ApiPost) -> String? {
        let photoPath = apiPost.photo1280 != nil ? apiPost.photo1280 : apiPost.photo500 != nil ? apiPost.photo500 : nil
        return photoPath
    }
    
    private func findThumbnailPhotoPath(_ apiPost: ApiPost) -> String? {
        let photoPath = apiPost.photo400 != nil ? apiPost.photo400 : apiPost.photo100 != nil ? apiPost.photo100 : nil
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
