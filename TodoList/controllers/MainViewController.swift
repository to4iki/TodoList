//
//  MainViewController.swift
//  TodoList
//
//  Created by to4iki on 2/23/16.
//  Copyright © 2016 to4iki. All rights reserved.
//

import UIKit
import RealmSwift

/// Todo Create
final class MainViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView! {
        didSet {
            autoFocus()
        }
    }
    
    private lazy var todoRepository = TodoRepository.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onAddButton(sender: UIButton) {
        guard let text = textView.text where text != "" else {
            print("text is empty.")
            return
        }
        
        addTodo(text)
        
        clearTextView()
    }
}

extension MainViewController {
    
    private func autoFocus() {
        textView.becomeFirstResponder()
    }
    
    private func clearTextView() {
        textView.text = ""
    }
}

// MARK: - Segue

extension MainViewController {
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard let todoListViewController = segue.destinationViewController.childViewControllers.first as? TodoListViewController
            where segue.identifier == "TodoListSegue" else { fatalError() }
        
        todoListViewController.closeCompletionHandler = {
            print("close todo list view controller")
        }
    }
}

// MARK: - I/O

extension MainViewController {
    
    private func addTodo(text: String) {
        let todo = TodoFactory.instance(text)
        
        do {
            try todoRepository.add(todo)
        } catch {
            print("failure add todo.")
        }
    }
}