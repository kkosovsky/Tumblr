//
//  FavouritesWireframe.swift
//  Tumblr
//
//  Created by Kamil Kosowski on 24.01.2017.
//  Copyright © 2017 Kamil Kosowski. All rights reserved.
//

import Foundation

class FavouritesWireframe {
    
    private var favouritesViewController: FavouritesViewController?
    var favouritesPresenter: FavouritesPresenter?
    var rootWireframe: RootWireframe?
    
    func initializeInterface() {
        guard let favouritesPresenter = favouritesPresenter else { return }
        favouritesViewController = FavouritesViewController(withEventHandler: favouritesPresenter)
        favouritesPresenter.favouritesViewController = favouritesViewController
        rootWireframe?.appendToWireframe(favouritesViewController)
    }
    
}
