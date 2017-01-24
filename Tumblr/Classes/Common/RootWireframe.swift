//
//  RootWireframe.swift
//  Tumblr
//
//  Created by Kamil Kosowski on 11.01.2017.
//  Copyright © 2017 Kamil Kosowski. All rights reserved.
//

import UIKit

class RootWireframe: NSObject {

    var viewControllers = [UIViewController]()
    
    func show(inWindow window: UIWindow) {
        let navigationControllers = viewControllers.map { instantiateNavigationController(withFirstViewController: $0) }
        let tabBarController = instantiateTabBarController(withNavigationControllers: navigationControllers)
        guard let items = tabBarController.tabBar.items else { return }
        items[0].title = "Posts"
        items[1].title = "Favourites"
        window.rootViewController = tabBarController
    }
    
    func appendToWireframe(_ viewController: UIViewController?) {
        guard let viewController = viewController else { return }
        viewControllers.append(viewController)
    }
    
    private func instantiateNavigationController(withFirstViewController viewController: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController()
        navigationController.viewControllers = [viewController]
        return navigationController
    }
    
    private func instantiateTabBarController(withNavigationControllers navigationControllers: [UINavigationController]) -> UITabBarController {
        let tabBarController = UITabBarController(nibName: nil, bundle: nil)
        tabBarController.viewControllers = navigationControllers
        tabBarController.delegate = self
        return tabBarController
    }
}

extension RootWireframe: UITabBarControllerDelegate {
   
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        // TODO: next scene
    }
    
}
