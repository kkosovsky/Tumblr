//
//  FavouritesInteractorIO.swift
//  Tumblr
//
//  Created by Kamil Kosowski on 24.01.2017.
//  Copyright © 2017 Kamil Kosowski. All rights reserved.
//

import Foundation
import RxSwift

protocol FavouritesInteractorInput {

    func fetchFavouritePosts(source: Source) -> Observable<[Post]>
    
}


protocol FavouritesInteractorOutput {

    func presentData(_ databasePosts: Observable<[Post]>) -> Observable<[Post]>
    
}
