//
//  TextField.swift
//  Alarstudios
//
//  Created by Maksim Linkov on 19.03.2022.
//

import Foundation
import UIKit

final class TextField: UITextField {
    
    func customize() {
        layer.borderWidth = 1.0
        layer.borderColor = UIColor(named: "borderColor")?.cgColor
        layer.cornerRadius = 7
        returnKeyType = .done
        textColor = .black
        
        translatesAutoresizingMaskIntoConstraints = false
        autocapitalizationType = .none
    }
    
    let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    
    override public func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override public func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override public func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override var placeholder: String? {
        didSet {
            if let placeholder = placeholder {
                
                let newPlaceholder = NSAttributedString(
                    string: placeholder,
                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
                )
                attributedPlaceholder = newPlaceholder
            }
        }
    }
    
}
