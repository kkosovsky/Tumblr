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
    var searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.placeholder = "Enter blog name"
        return searchBar
    }()
    
    
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
        DatabaseManager().clearDatabase()
        postsListView.postsTableView.delegate = self
        postsListView.postsTableView.register(PostsListPhotoTableViewCell.self)
        configureDataSource()
        bindPostsToTableView()
        subscribePosts()
        addSearchBar()
        postsListView.postsTableView.estimatedRowHeight = 500
        postsListView.postsTableView.rowHeight = UITableViewAutomaticDimension
    }
    
    private func subscribePosts() {
        posts.asObservable().subscribe(onNext: { [weak self] postsArray in
            self?.eventHandler?.passPostsForCache(postsArray)
        }).addDisposableTo(disposeBag)
    }
    
    private func configureDataSource() {
        dataSource.configureCell = { [weak self] dataSource, tableView, indexPath, item in
            guard let unwrappedSelf = self else { return UITableViewCell() }
            let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as PostsListPhotoTableViewCell
            cell.setup(withItem: item, eventHandler: unwrappedSelf.eventHandler)
            return cell
        }
    }
    
    private func addSearchBar() {
        navigationItem.titleView = searchBar
        searchBar.rx.text.throttle(1.0, scheduler: MainScheduler.instance).subscribe { [weak self] (event) in
            guard let assuredSelf = self, let element = event.element else { return }
            assuredSelf.eventHandler?.feedWithPosts(.Api, blogName: element).bindTo(assuredSelf.posts).addDisposableTo(assuredSelf.disposeBag)
            }.addDisposableTo(disposeBag)
    }
    
    private func bindPostsToTableView() {
        posts.asObservable()
            .flatMap { Observable.just( $0.map { SectionOfPostData(header: $0.id, items: [$0]) } ) }
            .bindTo(postsListView.postsTableView.rx.items(dataSource: dataSource))
            .addDisposableTo(disposeBag)
    }
    
}

extension PostsListViewController: UITableViewDelegate {
    
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
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
    }
    
}
