//
//  UIViewController+Extension.swift
//  Yummy
//
//  Created by Khánh Lâm Gia on 23/07/2021.
//

import UIKit

extension UIViewController {
    static var identifier: String {
        return String(describing: self)
    }
    
    static func instantiate() -> Self {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(identifier: identifier) as! Self
    }
}
