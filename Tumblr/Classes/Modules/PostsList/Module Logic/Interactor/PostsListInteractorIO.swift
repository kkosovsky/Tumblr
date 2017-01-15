//
//  PostsListInteractorIO.swift
//  Tumblr
//
//  Created by Kamil Kosowski on 15.01.2017.
//  Copyright © 2017 Kamil Kosowski. All rights reserved.
//

import Foundation
import RxSwift

protocol PostsListInteractorInput {

    func getAllPosts() -> Observable<[ApiPost]>
    func fetchImage(forImageView imageView: UIImageView, withPath path: String) -> URLSessionDataTask?
    
}


protocol PostsListInteractorOutput {
    
    func showAllPosts() -> Observable<[ApiPost]>
    
}
