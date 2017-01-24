//
//  FavouritesViewController.swift
//  Tumblr
//
//  Created by Kamil Kosowski on 24.01.2017.
//  Copyright © 2017 Kamil Kosowski. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class FavouritesViewController: UIViewController {

    let favouritesView = FavouritesView()
    let posts = Variable<[Post]>([])
    let disposeBag = DisposeBag()
    let dataSource = RxTableViewSectionedReloadDataSource<SectionOfPostData>()
    var eventHandler: FavouritesModuleInterface?
    
    init(withEventHandler eventHandler: FavouritesModuleInterface) {
        super.init(nibName: nil, bundle: nil)
        self.eventHandler = eventHandler
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = favouritesView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favouritesView.favouritesTableView.delegate = self
        favouritesView.favouritesTableView.register(PostsListPhotoTableViewCell.self)
        configureDataSource()
        bindPostsToTableView()
        addUISegmentedControl()
    }
    
    private func configureDataSource() {
        dataSource.configureCell = { [weak self] dataSource, tableView, indexPath, item in
            guard let unwrappedSelf = self else { return UITableViewCell() }
            let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as FavouritesTableViewCell
            cell.setup(withItem: item)
            return cell
        }
    }
    
    private func bindPostsToTableView() {
        posts.asObservable()
            .flatMap { Observable.just( $0.map { SectionOfPostData(header: $0.id, items: [$0]) } ) }
            .bindTo(favouritesView.favouritesTableView.rx.items(dataSource: dataSource))
            .addDisposableTo(disposeBag)
    }
    
    private func addUISegmentedControl() {
        let segmentedControl = UISegmentedControl(items: ["Post Id", "Post Type"])
        segmentedControl.selectedSegmentIndex = 0
        navigationItem.titleView = segmentedControl
        segmentedControl.rx.controlEvent(.valueChanged).subscribe(onNext: { [weak self] in
            //self?.eventHandler?.sortUsers(segmentedControl.selectedSegmentIndex)
        }).addDisposableTo(disposeBag)
    }

}

extension FavouritesViewController: UITableViewDelegate {
    
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
