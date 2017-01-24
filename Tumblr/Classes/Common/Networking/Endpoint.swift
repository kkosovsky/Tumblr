//
//  Endpoint.swift
//  Tumblr
//
//  Created by Kamil Kosowski on 11.01.2017.
//  Copyright © 2017 Kamil Kosowski. All rights reserved.
//

import Foundation

protocol NetworkService {
    
    var baseUrl: String { get }
    var path: String { get }
    var format: String { get }
    
}

enum Endpoint: NetworkService {
    
    case getAllPosts(String)
    
    var baseUrl: String {
        switch self {
        case .getAllPosts(let username):
            return "http://\(username).tumblr.com/"
        }
        
    }
    
    var path: String {
        return "api/read/"
    }
    
    var format: String {
        return "json"
    }
    
}
