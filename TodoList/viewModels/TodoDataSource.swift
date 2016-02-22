//
//  TodoDataSource.swift
//  TodoList
//
//  Created by to4iki on 2/23/16.
//  Copyright © 2016 to4iki. All rights reserved.
//

import UIKit

/// ViewModel
final class TodoDataSource: NSObject {
}

extension TodoDataSource: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(TodoTableViewCell.CellIdentifier, forIndexPath: indexPath)
        
        guard let todoCell = cell as? TodoTableViewCell else {
            return cell
        }
        
        todoCell.setup(indexPath.row)
        
        return todoCell
    }
}