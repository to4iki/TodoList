//
//  TodoTableViewCell.swift
//  TodoList
//
//  Created by to4iki on 2/23/16.
//  Copyright © 2016 to4iki. All rights reserved.
//

import UIKit

final class TodoTableViewCell: UITableViewCell {
    
    static let NibName = "TodoTableViewCell"
    
    static let CellIdentifier = "TodoCell"
    
    @IBOutlet weak var label: UILabel!
    
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
    
    func setup(index: Int) {
        label.text = "index: \(index)"
    }
}