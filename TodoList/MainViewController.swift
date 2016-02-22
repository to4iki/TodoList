//
//  MainViewController.swift
//  TodoList
//
//  Created by to4iki on 2/23/16.
//  Copyright © 2016 to4iki. All rights reserved.
//

import UIKit

/// Todo Create
final class MainViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        autoFocus()
    }
    
    @IBAction func onAddButton(sender: UIButton) {
        guard let text = textField.text where text != "" else {
            print("text is empty.")
            return
        }
        
        print(text)
    }
}

extension MainViewController {
    
    private func autoFocus() {
        if textField.resignFirstResponder() {
            textField.becomeFirstResponder()
        }
    }
}