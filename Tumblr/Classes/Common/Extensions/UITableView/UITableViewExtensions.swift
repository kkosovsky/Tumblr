//
//  UITableViewExtensions.swift
//  RandomUser
//
//  Created by Kamil on 29.12.2016.
//  Copyright © 2016 Kamil. All rights reserved.
//

import UIKit

extension UITableView {
    
    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue reusable cell with identifier :\(T.reuseIdentifier)")
        }
        return cell
    }
    
    func register<T: UITableViewCell>(_ tableViewCell: T.Type) {
        register(T.self, forCellReuseIdentifier: String(describing: T.self))
    }
    
}
