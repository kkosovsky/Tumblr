//
//  PostsListViewController.swift
//  Tumblr
//
//  Created by Kamil Kosowski on 11.01.2017.
//  Copyright © 2017 Kamil Kosowski. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PostsListViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    let posts = Variable<[Post]>([])
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = PostsListView()
        
    }
    
    
}

