//
//  ReusableView.swift
//  RandomUser
//
//  Created by Kamil on 29.12.2016.
//  Copyright © 2016 Kamil. All rights reserved.
//

import UIKit

protocol ReusableView: class {}

extension ReusableView where Self: UIView {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
