//
//  PostsListNetworkInterface.swift
//  Tumblr
//
//  Created by Kamil Kosowski on 15.01.2017.
//  Copyright © 2017 Kamil Kosowski. All rights reserved.
//

import Foundation
import RxSwift

protocol PostsListNetworkInterface {
    
    func getAllPosts(_ blogName: String?) -> Observable<[ApiPost]>
    func cacheImage(data: Data, forPostEntity post: Post)

}
