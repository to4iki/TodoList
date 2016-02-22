//
//  TodoListViewController.swift
//  TodoList
//
//  Created by to4iki on 2/23/16.
//  Copyright © 2016 to4iki. All rights reserved.
//

import UIKit

/// Todo List
final class TodoListViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    private lazy var viewModel = TodoDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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