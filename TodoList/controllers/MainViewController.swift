//
//  MainViewController.swift
//  TodoList
//
//  Created by to4iki on 2/23/16.
//  Copyright © 2016 to4iki. All rights reserved.
//

import UIKit
import RealmSwift
import LiquidFloatingActionButton

/// Todo Create
final class MainViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView! {
        didSet {
            autoFocus()
        }
    }
    
    private let dataSource = MenuButtonDataSource()
    
    private lazy var todoRepository = TodoRepository.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
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
    
    private func setup() {
        let createButton: (CGRect, LiquidFloatingActionButtonAnimateStyle) -> LiquidFloatingActionButton = { (frame, style) in
            let floatingActionButton = LiquidFloatingActionButton(frame: frame)
            floatingActionButton.animateStyle = style
            floatingActionButton.dataSource = self.dataSource
            floatingActionButton.delegate = self
            return floatingActionButton
        }
        
        let floatingFrame = CGRect(x: view.frame.width - 56 - 16, y: view.frame.height - 56 - 16, width: 56, height: 56)
        let bottomRightButton = createButton(floatingFrame, .Up)
        
        view.addSubview(bottomRightButton)
    }
    
    private func autoFocus() {
        textView.becomeFirstResponder()
    }
    
    private func clearTextView() {
        textView.text = ""
    }
    
    private func openPhotoLibrary() {
        guard UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) else { return }
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .PhotoLibrary
        imagePickerController.allowsEditing = true
        imagePickerController.delegate = self
        presentViewController(imagePickerController, animated: true, completion: {
            print("present image picker controller")
        })
    }
}

// MARK: - LiquidFloatingActionButtonDelegate

extension MainViewController: LiquidFloatingActionButtonDelegate {
    
    func liquidFloatingActionButton(liquidFloatingActionButton: LiquidFloatingActionButton, didSelectItemAtIndex index: Int) {
        print("did Tapped \(index)")
        
        openPhotoLibrary()
        liquidFloatingActionButton.close()
    }
}

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate

extension MainViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        if let editingInfo = editingInfo, let editedImage = editingInfo[UIImagePickerControllerOriginalImage] as? UIImage {
            // TODO: save
            print(editedImage)
        }
        
        picker.dismissViewControllerAnimated(true, completion: {
            print("dismiss image picker controller")
        })
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