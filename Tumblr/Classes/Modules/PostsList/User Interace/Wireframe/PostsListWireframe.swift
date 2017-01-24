//
//  PostsListWireframe.swift
//  Tumblr
//
//  Created by Kamil Kosowski on 11.01.2017.
//  Copyright © 2017 Kamil Kosowski. All rights reserved.
//

import UIKit

class PostsListWireframe {
    
    var rootWireframe: RootWireframe?
    var postsListPresenter: PostsListPresenter?
    var postsListViewController: PostsListViewController?
    
     func presentPostsListInterface(inWindow window: UIWindow) {
        guard let postsListPresenter = postsListPresenter else { return }
        postsListViewController = PostsListViewController(withEventHandler: postsListPresenter)
        rootWireframe?.show(postsListViewController, inWindow: window)
    }
    
}
