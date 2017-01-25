//
//  PostsListWireframe.swift
//  Tumblr
//
//  Created by Kamil Kosowski on 11.01.2017.
//  Copyright © 2017 Kamil Kosowski. All rights reserved.
//

import UIKit

class PostsListWireframe {
    
    var postsListPresenter: PostsListPresenter?
    var postsListViewController: PostsListViewController?
    var rootWireframe: RootWireframe?
    
     func presentPostsListInterface(inWindow window: UIWindow) {
        rootWireframe?.show(inWindow: window)
    }
    
    func initializeInterface() {
        guard let postsListPresenter = postsListPresenter else { return }
        postsListViewController = PostsListViewController(withEventHandler: postsListPresenter)
        postsListPresenter.postsListViewController = postsListViewController
        rootWireframe?.appendToWireframe(postsListViewController)
    }
    
}
