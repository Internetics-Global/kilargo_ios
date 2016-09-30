//
//  SubMenuItemCell.swift
//  Kilargo
//
//  Created by Internetics on 27/04/2016.
//  Copyright © 2016 com.internetics. All rights reserved.
//

import Foundation
import UIKit

class SubMenuItemCell : UITableViewCell {
    
    class var identifier: String { return String.className(self) }
    
    @IBOutlet weak var titleLabel: UILabel!
    
}
