//
//  PostsListModuleInterface.swift
//  Tumblr
//
//  Created by Kamil Kosowski on 15.01.2017.
//  Copyright © 2017 Kamil Kosowski. All rights reserved.
//

import Foundation
import RxSwift

protocol PostsListModuleInterface {
    
    func feedWithPosts() -> Observable<[ApiPost]>
    func updateImageView(_ imagePath: String, imageView: UIImageView) -> URLSessionDataTask?
}
