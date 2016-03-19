//
//  MaterialTextField.swift
//  My Showcase
//
//  Created by Joseph Pilon on 3/19/16.
//  Copyright © 2016 Gulp Technologies. All rights reserved.
//

import UIKit

class MaterialTextField: UITextField {

    override func awakeFromNib() {
        layer.cornerRadius = 2.0
        layer.borderColor = UIColor(red: SHADOW_COLOR, green: SHADOW_COLOR, blue: SHADOW_COLOR, alpha: 0.1).CGColor
        layer.borderWidth = 1.0
    }
    
    // Place Holder
//    override func textRectForBounds(bounds: CGRect) -> CGRect {
//        return CGRectInset(bounds, 10, 0)
//    }
    
    // Editable Text
//    override func editingRectForBounds(bounds: CGRect) -> CGRect {
//        return CGRectInset(bounds, 10, 0)
//    }

}
