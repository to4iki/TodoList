//
//  RealmSet.swift
//  TodoList
//
//  Created by to4iki on 2/23/16.
//  Copyright © 2016 to4iki. All rights reserved.
//

import Foundation
import RealmSwift

struct RealmSet {
    
    static func disc() throws -> Realm {
        return try Realm()
    }
    
    static func inMemory() throws -> Realm {
        return try Realm(configuration: Realm.Configuration(inMemoryIdentifier: "MyInMemoryRealm"))
    }
}