//
//  TodoListViewController.swift
//  TodoList
//
//  Created by to4iki on 2/23/16.
//  Copyright © 2016 to4iki. All rights reserved.
//

import UIKit
import RealmSwift

/// Todo List
final class TodoListViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    private var todos: Results<Todo>?
    
    private lazy var viewModel = TodoDataSource()
    
    private lazy var todoRepository = TodoRepository.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadTodos()
        setup()
    }
}

extension TodoListViewController {
    
    private func setup() {
        tableView.registerNib(TodoTableViewCell.nib(), forCellReuseIdentifier: TodoTableViewCell.CellIdentifier)
        
        tableView.delegate = self
        tableView.dataSource = viewModel
        
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
    }
}

// MARK: - UITableViewDelegate

extension TodoListViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .Default, title: "Delete", handler: { (action, indexPath) -> Void in
            self.viewModel.removeData(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Left)
            
            guard let todo = self.todos?[indexPath.row] else { return }
            self.deleteTodo(todo)
        })
        
        return [deleteAction]
    }
}

// MARK: - I/O

extension TodoListViewController {
    
    private func loadTodos() {
        todos = todoRepository.read()
        viewModel.setup(todos)
    }
    
    private func deleteTodo(todo: Todo) {
        do {
            try todoRepository.delete(todo)
        } catch {
            print("failure delete todo")
        }
    }
}