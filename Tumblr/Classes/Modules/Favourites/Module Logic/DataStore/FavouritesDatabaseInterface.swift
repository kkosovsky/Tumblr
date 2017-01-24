//
//  FavouritesDatabaseInterface.swift
//  Tumblr
//
//  Created by Kamil Kosowski on 24.01.2017.
//  Copyright © 2017 Kamil Kosowski. All rights reserved.
//

import Foundation
import RxSwift

protocol FavouritesDatabaseInterface {
    
    func fetchAllPosts() -> Observable<[DatabasePost]>
    
}
