//
//  UIView+Rounded.swift
//  Kilargo
//
//  Created by internetics on 27/09/2016.
//  Copyright © 2016 com.internetics. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}
