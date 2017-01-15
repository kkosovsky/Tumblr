//
//  DataExtensions.swift
//  Tumblr
//
//  Created by Kamil Kosowski on 11.01.2017.
//  Copyright © 2017 Kamil Kosowski. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

extension Data {
    
    func parse() -> Observable<[ApiPost]> {
        do {
            guard let apiStringUtf8 = String(data: self, encoding: .utf8) else { return Observable.empty() }
            let jsonString = apiStringUtf8.formatThumblrApiObjectToJson()
            guard let jsonAsData = jsonString.data(using: .utf8),
                  let json = try JSONSerialization.jsonObject(with: jsonAsData, options: .allowFragments) as? [String: AnyObject],
                  let postsArray = json["posts"] as? [AnyObject] else { return Observable.empty() }
            let posts = try [ApiPost].decode(postsArray)
            return Observable.just(posts)
        } catch {
            print(error)
        }
        return Observable.empty()
    }
    
}
