//
//  UITableViewCell+Reusable.swift
//  Marvel
//
//  Created by Gonzalo Diz on 29/10/2021.
//

import UIKit

extension UITableViewCell {
    static var cellIdentifier: String {
        String(describing: self)
    }
}
