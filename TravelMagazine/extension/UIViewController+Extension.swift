//
//  UIViewController+Extension.swift
//  TravelMagazine
//
//  Created by 쌩 on 5/30/24.
//

import UIKit

protocol ReuseIdentifierProtocol {
    static var identifier: String { get }
}

extension UIViewController: ReuseIdentifierProtocol {
 
       static var identifier: String {
            return String(describing: self)
        }
    
    
    @objc func keyboardDismiss() {
        view.endEditing(true)
    }
}

extension UITableViewCell: ReuseIdentifierProtocol {
    
    static var identifier: String {
        return String(describing: self)
    }
    
}
