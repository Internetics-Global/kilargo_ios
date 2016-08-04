//
//  ImageHeaderCell.swift
//  Kilargo
//
//  Created by Internetics on 22/04/2016.
//  Copyright © 2016 com.internetics. All rights reserved.
//

import UIKit

class ImageHeaderView : UIView {
    
    @IBOutlet weak var profileImage : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.whiteColor()
        self.profileImage.layer.cornerRadius = self.profileImage.frame.size.height / 2
        self.profileImage.clipsToBounds = true
        self.profileImage.layer.borderWidth = 0
        self.profileImage.layer.borderColor = UIColor.lightGrayColor().CGColor
        self.profileImage.image = UIImage(named: "logo")
    }   
}