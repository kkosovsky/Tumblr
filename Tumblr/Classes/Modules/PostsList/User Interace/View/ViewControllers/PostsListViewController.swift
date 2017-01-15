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
import RxDataSources

class PostsListViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    let posts = Variable<[Post]>([])
    let postsListView = PostsListView()
    let dataSource = RxTableViewSectionedReloadDataSource<SectionOfPostData>()
    var eventHandler: PostsListModuleInterface?
    
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
        postsListView.postsTableView.delegate = self
        eventHandler?.feedWithPosts().bindTo(posts).addDisposableTo(disposeBag)
        postsListView.postsTableView.register(PostsListTableViewCell.self)
        configureDataSource()
        bindPostsToTableView()
    }
    
    private func configureDataSource() {
        dataSource.configureCell = { dataSource, tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as PostsListTableViewCell
            cell.setup(item.date)
            return cell
        }
    }

    private func bindPostsToTableView() {
        posts.asObservable()
              .flatMap { Observable.just( $0.map { SectionOfPostData(header: $0.id, items: [$0]) } ) }
              .bindTo(postsListView.postsTableView.rx.items(dataSource: dataSource))
              .addDisposableTo(disposeBag)
    }
}

extension PostsListViewController: UITableViewDelegate {
 
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 550
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
