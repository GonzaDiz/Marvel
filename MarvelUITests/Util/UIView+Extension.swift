//
//  UIView+Extension.swift
//  MarvelUITests
//
//  Created by Gonzalo Diz on 29/10/2021.
//

import Foundation

extension UIView {
    var parentViewController: UIViewController? {
        // Starts from next (As we know self is not a UIViewController).
        var parentResponder: UIResponder? = self.next
        while parentResponder != nil {
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
            parentResponder = parentResponder?.next
        }
        return nil
    }
}
