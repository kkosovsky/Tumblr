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
    dynamic var thumbnailPath: String?
    dynamic var largeImagePath: String?
    dynamic var caption: String?
    var tags = List<Tag>()
    
    func setUp(withApiModel apiModel: ApiPost) {
        if let newId = Int(apiModel.id) {
            id = newId
        }
        url = apiModel.url
        type = apiModel.type
        date = apiModel.date
        caption = apiModel.photoCaption
        apiModel.tags?.forEach({ (apiFetchedTag) in
            let tag = Tag()
            tag.tagName = apiFetchedTag
            tags.append(tag)
        })
    }
}

class Tag: Object {
    
    dynamic var tagName: String = ""
    
}
