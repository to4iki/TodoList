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
    
    private var closeCompletionHandler: (() -> Void)?
    
    private var todos: Results<Todo>?
    
    private lazy var dataSource = TodoDataSource()
    
    private lazy var todoRepository = TodoRepository.sharedInstance
}

// MARK: - LifeCycle

extension TodoListViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        loadTodos()
    }
}

extension TodoListViewController {
    
    private func setup() {
        tableView.registerNib(TodoTableViewCell.nib(), forCellReuseIdentifier: TodoTableViewCell.CellIdentifier)
        
        tableView.delegate = self
        tableView.dataSource = dataSource
        
        configureDynamicCellSizing()
        hideSeparator()
    }
    
    private func configureDynamicCellSizing() {
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    // http://stackoverflow.com/questions/1633966/can-i-force-a-uitableview-to-hide-the-separator-between-empty-cells
    private func hideSeparator() {
        let view = UIView(frame: CGRectZero)
        view.backgroundColor = UIColor.clearColor()
        tableView.tableHeaderView = view
        tableView.tableFooterView = view
    }
    
    func setCloseCompletionHandler(handler: () -> Void) {
        closeCompletionHandler = handler
    }
    
    @IBAction func onCloseButton(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: closeCompletionHandler)
    }
}

// MARK: - UITableViewDelegate

extension TodoListViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .Default, title: "Delete", handler: { (action, indexPath) -> Void in
            self.dataSource.removeData(indexPath.row)
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
        dataSource.setup(todos)
    }
    
    private func deleteTodo(todo: Todo) {
        do {
            try todoRepository.delete(todo)
        } catch {
            print("failure delete todo")
        }
    }
}