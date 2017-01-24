//
//  Reactive+URLSession.swift
//  Tumblr
//
//  Created by Kamil Kosowski on 11.01.2017.
//  Copyright © 2017 Kamil Kosowski. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension Reactive where Base: URLSession {
    
    public func fetchRequest(_ request: URLRequest) -> Observable<(Data, HTTPURLResponse)> {
        return Observable.create { observer in
            let task = self.base.dataTask(with: request) { (data, response, error) in
                guard let response = response, let data = data else {
                    observer.on(.error(error ?? RxCocoaURLError.unknown))
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse else {
                    observer.on(.error(RxCocoaURLError.nonHTTPResponse(response: response)))
                    return
                }
                observer.onNext((data, httpResponse))
                observer.onCompleted()
            }
            task.resume()
            return Disposables.create { task.cancel() }
        }
    }
    
}

