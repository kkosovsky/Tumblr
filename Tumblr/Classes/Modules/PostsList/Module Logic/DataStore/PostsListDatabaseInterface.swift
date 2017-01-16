//
//  PostsListDatabaseInterface.swift
//  Tumblr
//
//  Created by Kamil Kosowski on 15.01.2017.
//  Copyright © 2017 Kamil Kosowski. All rights reserved.
//

import Foundation

protocol PostsListDatabaseInterface {

    func cachePostsData(_ posts: [DatabasePost])
    
}
