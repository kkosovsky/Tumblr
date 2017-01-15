//
//  Post.swift
//  Tumblr
//
//  Created by Kamil Kosowski on 11.01.2017.
//  Copyright © 2017 Kamil Kosowski. All rights reserved.
//

import Foundation
import Decodable


struct Post {
    
    var id: String
    var url: String
    var type: String
    var date: String
    var photo1280: String?
    var photo500: String?
    var photo400: String?
    var photo100: String?
    var photoCaption: String?
    var tags: [String]?
}

extension Post: Decodable {
    
    static func decode(_ json: Any) throws -> Post {
        return try Post(
            id: json => "id",
            url: json => "url",
            type: json => "type",
            date: json => "date",
            photo1280: json =>? "photo-url-1280",
            photo500: json =>? "photo-url-500",
            photo400: json =>? "photo-url-400",
            photo100: json =>? "photo-url-100",
            photoCaption: json =>? "photo-caption",
            tags: json =>? "tags"
        )
    }
}
