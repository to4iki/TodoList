//
//  Todo.swift
//  TodoList
//
//  Created by to4iki on 2/23/16.
//  Copyright © 2016 to4iki. All rights reserved.
//

import Foundation
import RealmSwift

// MARK: - Model

class Todo: Object {
    
    dynamic var name: String = ""
    
    dynamic var createdAt: NSDate = NSDate()
}

// MARK: - Factory

struct TodoFactory {
    
    static func instance(name: String) -> Todo {
        let todo = Todo()
        todo.name = name
        
        return todo
    }
}

// MARK: - Repository

struct TodoRepository {
    
    private let realm: Realm
    
    static var sharedInstance: TodoRepository? {
        guard let realm = try? RealmSet.inMemory() else {
            print("failure realm setup.")
            return nil
        }
        return TodoRepository(realm: realm)
    }
    
    private init(realm: Realm) {
        self.realm = realm
    }
    
    func read() -> Results<Todo> {
        return realm.objects(Todo).sorted("createdAt", ascending: false)
    }
    
    func add(todo: Todo) throws {
        try realm.write {
            realm.add(todo)
        }
    }
}