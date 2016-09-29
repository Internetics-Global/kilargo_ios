//
//  SearchResultCell.swift
//  Kilargo
//
//  Created by Internetics on 4/08/2016.
//  Copyright © 2016 com.internetics. All rights reserved.
//

import Foundation
import UIKit

class InfoDialogCell: UITableViewCell {
    
    class var identifier: String { return String.className(self) }
    
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
}
