//
//  UIViewController+loadFromNib.swift
//  Alarstudios
//
//  Created by Maksim Linkov on 21.03.2022.
//

import UIKit

extension UIViewController {
    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }
        
        return instantiateFromNib()
    }
}
