//
//  ApiManager.swift
//  Tumblr
//
//  Created by Kamil Kosowski on 11.01.2017.
//  Copyright © 2017 Kamil Kosowski. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ApiManager {
    
    func requestUsers(endpoint: Endpoint) -> Observable<[Post]>  {
        guard let url = URL.urlFor(endpoint: endpoint) else { return Observable.empty() }
        let request = URLRequest(url: url)
        return URLSession.shared.rx.fetchRequest(request)
            .observeOn(MainScheduler.instance)
            .flatMap({ (data, response) -> Observable<[Post]> in
                let posts = data.parse()
                return posts
            })
            .shareReplay(1)
        
       // .flatMap{ $0.0.parse() }
    }
    
}
