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
        
        loadTodo()
        setup()
    }
}

extension TodoListViewController {
    
    private func setup() {
        tableView.registerNib(TodoTableViewCell.nib(), forCellReuseIdentifier: TodoTableViewCell.CellIdentifier)
        tableView.delegate = self
        tableView.dataSource = viewModel
    }
}

// MARK: - UITableViewDelegate

extension TodoListViewController: UITableViewDelegate {
}

// MARK: - I/O

extension TodoListViewController {
    
    private func loadTodo() {
        todos = todoRepository?.read()
        viewModel.setup(todos)
    }
}