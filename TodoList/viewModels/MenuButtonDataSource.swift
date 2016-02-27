//
//  MenuButtonDataSource.swift
//  TodoList
//
//  Created by to4iki on 2/27/16.
//  Copyright © 2016 to4iki. All rights reserved.
//

import Foundation
import LiquidFloatingActionButton

final class MenuButtonDataSource: NSObject {
    
    // dummy
    private let cells: [LiquidFloatingCell] = [
        LiquidFloatingCell(icon: UIImage(named: "ic_system")!)
    ]
}

// MARK: - LiquidFloatingActionButtonDataSource

extension MenuButtonDataSource: LiquidFloatingActionButtonDataSource {
    
    func numberOfCells(liquidFloatingActionButton: LiquidFloatingActionButton) -> Int {
        return cells.count
    }
    
    func cellForIndex(index: Int) -> LiquidFloatingCell {
        return cells[index]
    }
}