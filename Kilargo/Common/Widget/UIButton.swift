//
//  UIButton.swift
//  Kilargo
//
//  Created by Internetics on 4/08/2016.
//  Copyright © 2016 com.internetics. All rights reserved.
//

import Foundation
import UIKit

private let MINIMUM_HIT_AREA = CGSize(width: 44, height: 44)

extension UIButton {
    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        
        if self.isHidden || !self.isUserInteractionEnabled || self.alpha < 0.01 { return nil }
        
        let buttonSize = self.bounds.size
        let widthToAdd = max(MINIMUM_HIT_AREA.width - buttonSize.width, 0)
        let heightToAdd = max(MINIMUM_HIT_AREA.height - buttonSize.height, 0)
        let largerFrame = self.bounds.insetBy(dx: -widthToAdd / 2, dy: -heightToAdd / 2)
        
        return (largerFrame.contains(point)) ? self : nil
    }
}
