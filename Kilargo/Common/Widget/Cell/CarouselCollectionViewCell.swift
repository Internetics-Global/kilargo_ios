//
//  CarouselCollectionViewCell.swift
//  Kilargo
//
//  Created by Internetics on 4/05/2016.
//  Copyright © 2016 com.internetics. All rights reserved.
//

import Foundation
import UIKit

class CarouselCollectionViewCell: UICollectionViewCell {
    
    
    var product: Product! {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet weak var featuredImageView: UIImageView!
    
    fileprivate func updateUI() {
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 5.0
        self.clipsToBounds = true
    }
}
