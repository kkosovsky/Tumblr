//
//  PostsListViewController.swift
//  Tumblr
//
//  Created by Kamil Kosowski on 11.01.2017.
//  Copyright © 2017 Kamil Kosowski. All rights reserved.
//

import UIKit

class PostsListViewController: UIViewController {

    let apiManager = ApiManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = PostsListView()
        
          apiManager.requestUsers(endpoint: Endpoint.getAllPosts("beauty")).subscribe(onNext: { posts in
            print("posty to: ", posts)
          })
        
    }
}
