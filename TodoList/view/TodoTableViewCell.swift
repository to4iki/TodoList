//
//  TodoTableViewCell.swift
//  TodoList
//
//  Created by to4iki on 2/23/16.
//  Copyright © 2016 to4iki. All rights reserved.
//

import UIKit

/// View
final class TodoTableViewCell: UITableViewCell {
    
    static let NibName = "TodoTableViewCell"
    
    static let CellIdentifier = "TodoCell"
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var createdAt: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: TodoTableViewCell.NibName, bundle: nil)
    }
}

extension TodoTableViewCell {
    
    func setup(src: TodoDataSource.Dto) {
        name.text = src.name
        createdAt.text = src.createdAt
    }
}