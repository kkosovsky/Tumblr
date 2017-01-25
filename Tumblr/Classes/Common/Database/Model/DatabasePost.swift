//
//  DatabasePost.swift
//  Tumblr
//
//  Created by Kamil Kosowski on 15.01.2017.
//  Copyright © 2017 Kamil Kosowski. All rights reserved.
//

import Foundation
import RealmSwift

class DatabasePost: Object {
    
    dynamic var id = 0
    dynamic var url = ""
    dynamic var type = ""
    dynamic var date = ""
    dynamic var smallPhotoPath: String?
    dynamic var largePhotoPath: String?
    dynamic var smallPhoto: Data?
    dynamic var largePhoto: Data?
    dynamic var photoCaption: String?
    dynamic var isFavourite = false
    dynamic var quoteText: String?
    var tags = List<Tag>()
    
    func setUp(withapiPost apiPost: ApiPost) {
        if let newId = Int(apiPost.id) {
            id = newId
        }
        url = apiPost.url
        type = apiPost.type
        date = apiPost.date
        photoCaption = apiPost.photoCaption
        apiPost.tags?.forEach({ (apiFetchedTag) in
            let tag = Tag()
            tag.tagName = apiFetchedTag
            tags.append(tag)
        })
        quoteText = apiPost.quoteText
    }
    
    func setUp(withPlainObjectModel post: Post) {
        id = post.id
        url = post.url
        type = post.type
        date = post.date
        smallPhotoPath = post.smalllPhotoPath
        largePhotoPath = post.largePhotoPath
        smallPhoto = post.smallPhoto
        largePhoto = post.largePhoto
        photoCaption = post.photoCaption
        isFavourite = post.isFavourite
        post.tags?.forEach({ (apiFetchedTag) in
            let tag = Tag()
            tag.tagName = apiFetchedTag
            tags.append(tag)
        })
        quoteText = post.quoteText
    }
    
}

class Tag: Object {
    
    dynamic var tagName: String = ""
    
}
