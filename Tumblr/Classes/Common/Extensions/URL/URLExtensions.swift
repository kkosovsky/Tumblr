//
//  URLExtensions.swift
//  RandomUser
//
//  Created by Kamil Kosowski on 29.12.2016.
//  Copyright © 2016 Kamil. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

extension URL {
    
    static func urlFor(endpoint: Endpoint) -> URL? {
        guard let url = URL(string: endpoint.baseUrl + endpoint.path), var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return nil }
        components.queryItems = endpoint.parameters.map { URLQueryItem(name: $0, value: $1) }
        return components.url
    }
}
