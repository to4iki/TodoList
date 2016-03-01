//
//  MainViewController.swift
//  TodoList
//
//  Created by to4iki on 2/23/16.
//  Copyright © 2016 to4iki. All rights reserved.
//

import UIKit
import RealmSwift
import RxSwift
import RxCocoa

/// Todo Create
final class MainViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var addButton: UIButton! {
        didSet {
            addButton.enabled = false
        }
    }
    
    private let disposeBag = DisposeBag()
    
    private lazy var todoRepository = TodoRepository.sharedInstance
}

// MARK: - LifeCycle

extension MainViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        autoFocus()
    }
}

// MARK: - Action

extension MainViewController {
    
    @IBAction func onAddButton(sender: UIButton) {
        guard let text = textView.text else { return }
        
        addTodo(text)
        clearTextView()
    }
}

extension MainViewController {
    
    private func bind() {
        textView.rx_text
            .map({ !$0.isEmpty })
            .bindTo(addButton.rx_enabled)
            .addDisposableTo(disposeBag)
    }
    
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
        
        todoListViewController.setCloseCompletionHandler({
            print("close todo list view controller")
            self.autoFocus()
        })
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