//
//  UIButton.swift
//  Kilargo
//
//  Created by Internetics on 4/08/2016.
//  Copyright © 2016 com.internetics. All rights reserved.
//

import Foundation
import UIKit

private let MINIMUM_HIT_AREA = CGSizeMake(44, 44)

extension UIButton {
    public override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
        
        if self.hidden || !self.userInteractionEnabled || self.alpha < 0.01 { return nil }
        
        let buttonSize = self.bounds.size
        let widthToAdd = max(MINIMUM_HIT_AREA.width - buttonSize.width, 0)
        let heightToAdd = max(MINIMUM_HIT_AREA.height - buttonSize.height, 0)
        let largerFrame = CGRectInset(self.bounds, -widthToAdd / 2, -heightToAdd / 2)
        
        return (CGRectContainsPoint(largerFrame, point)) ? self : nil
    }
}
