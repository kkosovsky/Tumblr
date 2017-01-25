//
//  Post.swift
//  Tumblr
//
//  Created by Kamil Kosowski on 11.01.2017.
//  Copyright © 2017 Kamil Kosowski. All rights reserved.
//

import Foundation
import Mapper

struct ApiPost: Mappable {
    
    let id: String
    let url: String
    let type: String
    let date: String
    var photo1280: String?
    var photo500: String?
    var photo400: String?
    var photo100: String?
    var photoCaption: String?
    var tags: [String]?
    var quoteText: String?

    init(map: Mapper) throws {
        try id = map.from("id")
        try url = map.from("url")
        try type = map.from("type")
        try date = map.from("date")
        photo1280 = map.optionalFrom("photo-url-1280")
        photo500 = map.optionalFrom("photo-url-500")
        photo400 = map.optionalFrom("photo-url-400")
        photo100 = map.optionalFrom("photo-url-100")
        photoCaption = map.optionalFrom("photo-caption")
        tags = map.optionalFrom("tags")
        quoteText = map.optionalFrom("quote-text")
    }
}
