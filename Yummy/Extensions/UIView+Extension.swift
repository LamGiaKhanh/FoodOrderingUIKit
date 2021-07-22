//
//  UiView + Extension.swift
//  Yummy
//
//  Created by Khánh Lâm Gia on 20/07/2021.
//

import UIKit


extension UIView {
   @IBInspectable var cornerRadius: CGFloat {
        get { return cornerRadius}
        set {
            self.layer.cornerRadius = newValue
            
        }
    }
}
