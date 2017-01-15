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
    var eventHandler: PostsListModuleInterface?
    
    init(withEventHandler eventHandler: PostsListModuleInterface) {
        super.init(nibName: nil, bundle: nil)
        self.eventHandler = eventHandler
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = PostsListView()
        eventHandler?.feedWithPosts().bindTo(posts).addDisposableTo(disposeBag)
    }
    
    private func bindUsersTo(_ tableView: UITableView?) {
        guard let tableView = tableView else { return }
        posts.asObservable().bindTo(tableView.rx.items) { (tableView, row, user) in
            let cell = tableView.dequeueReusableCell(forIndexPath: IndexPath(row: row, section: 0)) as PostsListTableViewCell
            //TODO: cell setup
            return cell
            }.addDisposableTo(disposeBag)
    }
}

