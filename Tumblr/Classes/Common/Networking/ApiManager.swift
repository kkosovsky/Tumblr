//
//  ApiManager.swift
//  Tumblr
//
//  Created by Kamil Kosowski on 11.01.2017.
//  Copyright © 2017 Kamil Kosowski. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ApiManager {
    
    func requestPosts(endpoint: Endpoint) -> Observable<[ApiPost]>  {
        guard let url = URL.urlFor(endpoint: endpoint) else { return Observable.empty() }
        let request = URLRequest(url: url)
        return URLSession.shared.rx.fetchRequest(request)
            .observeOn(MainScheduler.instance)
            .flatMap{ $0.0.parse() }
            .shareReplay(1)
    }
    
    func fetchImage(_ imageView: UIImageView, imagePath: String, completion: @escaping (_ data: Data) -> Void) -> URLSessionDataTask? {
        guard let url = URL(string: imagePath) else { return nil }
        return URLSession(configuration: .ephemeral).dataTask(with: url) { data, response, error in
            guard let myData = data else { return }
            //user.pictureThumbnail = myData
            DispatchQueue.main.async {
                imageView.image = UIImage(data:myData)
                completion(myData)
            }
        }

    }
    
}
