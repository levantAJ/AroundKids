//
//  UITableView.swift
//  DequeueKit
//
//  Created by Tai Le on 11/17/19.
//  Copyright © 2019 Tai Le. All rights reserved.
//

import UIKit

public extension UITableView {
    func register<CellType: UITableViewCell>(class type: CellType.Type) {
        let identifier = String(describing: type)
        register(type, forCellReuseIdentifier: identifier)
    }
    
    func register<CellType: UITableViewCell>(nib type: CellType.Type) {
        let identifier = String(describing: type)
        let nib = UINib(nibName: identifier, bundle: nil)
        register(nib, forCellReuseIdentifier: identifier)
    }
    
    func dequeueReusableCell<CellType: UITableViewCell>(type: CellType.Type, for indexPath: IndexPath) -> CellType {
        let identifier = String(describing: type)
        return dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! CellType
    }
}
