//
//  FavouritesPresenter.swift
//  Tumblr
//
//  Created by Kamil Kosowski on 24.01.2017.
//  Copyright © 2017 Kamil Kosowski. All rights reserved.
//

import Foundation
import RxSwift

class FavouritesPresenter {
   
    var favouritesViewController: FavouritesViewController?
    
}

extension FavouritesPresenter: FavouritesInteractorOutput {
    
}

extension FavouritesPresenter: FavouritesModuleInterface {
    
    func sortUsers(by index: Int) {
        if index == 0 {
            favouritesViewController?.posts.value.sort { $0.0.date < $0.1.date }
        } else {
            favouritesViewController?.posts.value.sort { $0.0.type < $0.1.type }
        }
    }
    
    func fetchFavouritePosts(_ source: Source) -> Observable<[Post]> {
        return Observable.empty()
    }
    
}
