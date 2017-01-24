//
//  SectionOfPostData.swift
//  Tumblr
//
//  Created by Kamil Kosowski on 15.01.2017.
//  Copyright © 2017 Kamil Kosowski. All rights reserved.
//

import Foundation
import RxDataSources
import RxSwift


struct SectionOfPostData {
   
    var header: Int
    var items: [Item]
    
}

extension SectionOfPostData: SectionModelType {
    
    typealias Item = Post
    
    init(original: SectionOfPostData, items: [Item]) {
        self = original
        self.items = items
    }
}

protocol ReactiveSectionModelType {

    var isFavourite: Bool { get }
    
}
