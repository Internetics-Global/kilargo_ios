//
//  CarouselImageViewController.swift
//  Kilargo
//
//  Created by Internetics on 4/05/2016.
//  Copyright © 2016 com.internetics. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class CarouselImageViewController: BaseViewController {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var validImages:[String] = []
    
    var product:Product? {
        didSet {
            
            if (product!.image1.characters.count > 0) {
                validImages.append(product!.image1)
            }
            
            if (product!.image2.characters.count > 0) {
                validImages.append(product!.image2)
            }
            
            if (product!.image3.characters.count > 0) {
                validImages.append(product!.image3)
            }
            
            if (product!.image4.characters.count > 0) {
                validImages.append(product!.image4)
            }
            
            if (product!.image5.characters.count > 0) {
                validImages.append(product!.image5)
            }
            
            if (product!.productImage.characters.count > 0) {
                validImages.append(product!.productImage)
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(CarouselImageViewController.dimissViewController))
        self.view.userInteractionEnabled = true
        self.view.addGestureRecognizer(tapGestureRecognizer)
        
        self.collectionView.pagingEnabled = false


        
    }
    
    private struct Storyboard {
        static let CellIdentifier = "CarouselCellIdentifier"
    }
    
    
    func dimissViewController() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    override func prefersStatusBarHidden() -> Bool {
        return true;
    }
    
    
}


extension CarouselImageViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return validImages.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(Storyboard.CellIdentifier, forIndexPath: indexPath) as! CarouselCollectionViewCell
        
        let url = Global.imageBaseURL + self.validImages[indexPath.row]
        
        cell.featuredImageView.kf_setImageWithURL(NSURL(string: url)!, placeholderImage: UIImage(named: "placeholder"), optionsInfo: [.Transition(ImageTransition.Fade(1))], progressBlock: nil, completionHandler: nil)
        
        
        return cell
        
    }
    

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
         //80 is set in storyboard
        return CGSizeMake(CGRectGetWidth(self.view.frame) - 20*2,CGRectGetHeight(self.view.frame) - 80*2)
    }
    
    
    
    
}

