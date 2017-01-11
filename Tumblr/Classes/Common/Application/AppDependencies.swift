//
//  AppDependencies.swift
//  Tumblr
//
//  Created by Kamil Kosowski on 11.01.2017.
//  Copyright © 2017 Kamil Kosowski. All rights reserved.
//

import UIKit


class AppDependencies {
    
    var postsListWireframe = PostsListWireframe()
    
    init(forAppDelegate appDelegate: AppDelegate) {
        appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
        appDelegate.window?.makeKeyAndVisible()
        configureDependencies()
    }
    
    func installRootViewController(inWindow window: UIWindow?) {
        guard let window = window else { return }
        postsListWireframe.presentPostsListInterface(inWindow: window)
    }
    
     private func configureDependencies() {
        let rootWireframe = RootWireframe()
        postsListWireframe.rootWireframe = rootWireframe
    }
    
}
