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
    
    @IBOutlet weak var textField: UITextField!
    
    private lazy var todoRepository = TodoRepository.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        autoFocus()
    }
    
    @IBAction func onAddButton(sender: UIButton) {
        guard let text = textField.text where text != "" else {
            print("text is empty.")
            return
        }
        
        addTodo(text)
        
        clearTextField()
    }
}

extension MainViewController {
    
    private func autoFocus() {
        textField.becomeFirstResponder()
    }
    
    private func clearTextField() {
        textField.text = ""
    }
}

// MARK: - I/O

extension MainViewController {
    
    private func addTodo(text: String) {
        let todo = TodoFactory.instance(text)
        
        do {
            try todoRepository?.add(todo)
        } catch {
            print("failure add todo.")
        }
    }
}