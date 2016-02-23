//
//  TodoDataSource.swift
//  TodoList
//
//  Created by to4iki on 2/23/16.
//  Copyright © 2016 to4iki. All rights reserved.
//

import UIKit
import RealmSwift

/// View Model
final class TodoDataSource: NSObject {
    
    private var dtos: [Dto]? =  nil
    
    func setup(todos: Results<Todo>?) {
        guard let todos = todos else { return }
        dtos = todos.map(Dto.fromTodo)
    }
}

// MARK: - UITableViewDataSource

extension TodoDataSource: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dtos?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(TodoTableViewCell.CellIdentifier, forIndexPath: indexPath)
        
        guard let todoCell = cell as? TodoTableViewCell, daos = dtos else {
            return cell
        }
        
        todoCell.setup(daos[indexPath.row])
        
        return todoCell
    }
}

// MARK: - Data Transfer Object

extension TodoDataSource {
    
    struct Dto {
        let name: String
        let createdAt: NSDate
        
        static func fromTodo(todo: Todo) -> Dto {
            return Dto(name: todo.name, createdAt: todo.createdAt)
        }
    }
}
