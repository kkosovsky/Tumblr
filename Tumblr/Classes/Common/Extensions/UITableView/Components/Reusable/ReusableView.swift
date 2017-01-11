//
//  UITableViewExtensions.swift
//  Tumblr
//
//  Created by Kamil on 11.01.2016.
//  Copyright © 2017 Kamil. All rights reserved.
//

import UIKit

protocol ReusableView: class {}

extension ReusableView where Self: UIView {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
