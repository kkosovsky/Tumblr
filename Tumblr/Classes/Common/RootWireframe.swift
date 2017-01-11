//
//  RootWireframe.swift
//  Tumblr
//
//  Created by Kamil Kosowski on 11.01.2017.
//  Copyright © 2017 Kamil Kosowski. All rights reserved.
//

import UIKit

func show(_ viewController: UIViewController?, inWindow window: UIWindow) {
    guard let initialViewController = viewController else { return }
    window.rootViewController = instantiateNavigationController(withFirstViewController: initialViewController)
}

private func instantiateNavigationController(withFirstViewController viewController: UIViewController) -> UINavigationController {
    let navigationController = UINavigationController()
    navigationController.viewControllers = [viewController]
    return navigationController
}
