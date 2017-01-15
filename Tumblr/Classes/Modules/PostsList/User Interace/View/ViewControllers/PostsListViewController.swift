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
    let postsListView = PostsListView()
    
    init(withEventHandler eventHandler: PostsListModuleInterface) {
        super.init(nibName: nil, bundle: nil)
        self.eventHandler = eventHandler
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = postsListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventHandler?.feedWithPosts().bindTo(posts).addDisposableTo(disposeBag)
        postsListView.postsTableView.register(PostsListTableViewCell.self)
        postsListView.postsTableView.delegate = self
        bindUsersTo(postsListView.postsTableView)
    }
    
    private func bindUsersTo(_ tableView: UITableView?) {
        guard let tableView = tableView else { return }
        posts.asObservable().bindTo(tableView.rx.items) { (tableView, row, user) in
            let cell = tableView.dequeueReusableCell(forIndexPath: IndexPath(row: row, section: 0)) as PostsListTableViewCell
            cell.setup()
            return cell
            }.addDisposableTo(disposeBag)
    }
}

extension PostsListViewController: UITableViewDelegate {
 
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 450
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 25
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 25 : 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let view = UIView()
            view.backgroundColor = UIColor.clear
            return view
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }
    
}
