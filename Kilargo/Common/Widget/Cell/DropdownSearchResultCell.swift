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
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    
    open override func awakeFromNib() {
        setup()
    }
    
    private func setup() {
        self.accessoryView = UIImageView(image: UIImage(named: "right_arrow_gray"))
    }
    
	   
	
}
