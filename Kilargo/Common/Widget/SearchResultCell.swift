//
//  SearchResultCell.swift
//  Kilargo
//
//  Created by Internetics on 4/08/2016.
//  Copyright © 2016 com.internetics. All rights reserved.
//

import Foundation
import UIKit

class SearchResultCell: UITableViewCell {
    
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var productNameLabel: UILabel!
    
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    open override func awakeFromNib() {
        setup()
    }
    
    private func setup() {
        self.accessoryView = UIImageView(image: UIImage(named: "right_arrow_gray"))
    }
    
}
