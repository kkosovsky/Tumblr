//
//  UITableViewExtensions.swift
//  Tumblr
//
//  Created by Kamil on 11.01.2016.
//  Copyright © 2017 Kamil. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

extension URL {
    
    static func urlFor(endpoint: Endpoint) -> URL? {
        guard let url = URL(string: endpoint.baseUrl + endpoint.path + endpoint.format) else { return nil }
        return url
    }
}
