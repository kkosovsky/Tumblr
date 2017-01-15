//
//  SectionOfPostData.swift
//  Tumblr
//
//  Created by Kamil Kosowski on 15.01.2017.
//  Copyright © 2017 Kamil Kosowski. All rights reserved.
//

import Foundation
import RxDataSources


struct SectionOfPostData {
   
    var header: String
    var items: [Item]
    
}

extension SectionOfPostData: SectionModelType {
    
    typealias Item = ApiPost
    
    init(original: SectionOfPostData, items: [Item]) {
        self = original
        self.items = items
    }
    
}
