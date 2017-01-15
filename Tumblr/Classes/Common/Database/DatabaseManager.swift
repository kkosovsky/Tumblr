//
//  DatabaseManager.swift
//  Tumblr
//
//  Created by Kamil Kosowski on 15.01.2017.
//  Copyright © 2017 Kamil Kosowski. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift


class DatabaseManager {
    
    let realm = try! Realm()
    
    func clearDatabase() {
        try! realm.write {
            realm.deleteAll()
        }
    }
    
}
