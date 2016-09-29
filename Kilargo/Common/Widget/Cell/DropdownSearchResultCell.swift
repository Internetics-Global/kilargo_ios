//
//  MyCell.swift
//  DropDown
//
//  Created by Kevin Hirsch on 17/08/16.
//  Copyright © 2016 Kevin Hirsch. All rights reserved.
//

import UIKit
import DropDown

class DropdownSearchResultCell: DropDownCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    
    private func setup() {
        self.accessoryType = .disclosureIndicator
    }
    
	   
	
}
