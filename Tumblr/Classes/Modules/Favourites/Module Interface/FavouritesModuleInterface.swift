//
//  FavouritesModuleInterface.swift
//  Tumblr
//
//  Created by Kamil Kosowski on 24.01.2017.
//  Copyright © 2017 Kamil Kosowski. All rights reserved.
//

import Foundation
import RxSwift

protocol FavouritesModuleInterface {
    
    func sortUsers(by index: Int)
    func fetchFavouritePosts(_ source: Source) -> Observable<[Post]>
    
}
