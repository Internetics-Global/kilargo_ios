//
//  LeftTableViewCell.swift
//  Kilargo
//
//  Created by Internetics on 22/04/2016.
//  Copyright © 2016 com.internetics. All rights reserved.
//
import UIKit

public class LeftTableViewCell : UITableViewCell {
    class var identifier: String { return String.className(self) }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    public override func awakeFromNib() {
    }
    
    public func setup() {
    }
    
    public class func height() -> CGFloat {
        return 48
    }
    
    public func setData(data: Any?) {
        self.backgroundColor = UIColor(hex: "33394B")
        self.textLabel?.font = UIFont.systemFontOfSize(18)
        self.textLabel?.textColor = UIColor.whiteColor()
        if let menuText = data as? String {
            self.textLabel?.text = menuText
        }
    }
    
    override public func setHighlighted(highlighted: Bool, animated: Bool) {
        if highlighted {
            self.alpha = 0.7
        } else {
            self.alpha = 1.0
        }
    }
    
    // ignore the default handling
    override public func setSelected(selected: Bool, animated: Bool) {
    }
  
}
