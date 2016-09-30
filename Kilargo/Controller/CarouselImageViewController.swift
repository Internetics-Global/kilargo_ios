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

class CarouselImageViewController: UIViewController {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var pinchGestureRecognizer:UIGestureRecognizer?
    
    let kScaleBoundLower:CGFloat = 1;
    let kScaleBoundUpper:CGFloat = 5.0;
    var scaleStart:CGFloat = 0
    var _scale: CGFloat = 1.0
    var scale: CGFloat {
        get {
            return _scale
        }
        
        set(newScale) {
            if (newScale < kScaleBoundLower)
            {
                _scale = kScaleBoundLower;
            }
            else if (newScale > kScaleBoundUpper)
            {
                _scale = kScaleBoundUpper;
            } else {
                _scale = newScale
            }
            
            if (_scale > 1) {
                self.collectionView.isPagingEnabled = false
            } else {
                self.collectionView.isPagingEnabled = true
            }
            
            
        }
    }
    
    
    
    
    
    fileprivate var validImages:[String] = []
    
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
        
        self.scale = 1;
        
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(CarouselImageViewController.dimissViewController))
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(tapGestureRecognizer)
        
        pinchGestureRecognizer = UIPinchGestureRecognizer(target:self, action:#selector(CarouselImageViewController.didReceivePinchGesture))
        self.collectionView.addGestureRecognizer(pinchGestureRecognizer!)
        
        self.collectionView.isPagingEnabled = true

        
    }
    
    fileprivate struct Storyboard {
        static let CellIdentifier = "CarouselCellIdentifier"
    }
    
    
    func dimissViewController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func didReceivePinchGesture(pinchRecognizer: UIPinchGestureRecognizer) {
        
        print(pinchRecognizer.scale)
        
        if (pinchRecognizer.state == .began)
        {
            scaleStart = self.scale;
            return;
        }
        if (pinchRecognizer.state == .changed)
        {
            self.scale = scaleStart * pinchRecognizer.scale;
            
            self.collectionView.collectionViewLayout.invalidateLayout()
        }
        
        
    }
    
    override var prefersStatusBarHidden : Bool {
        return true;
    }
    
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return [.landscape]
    }
    
}


extension CarouselImageViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return validImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.CellIdentifier, for: indexPath) as! CarouselCollectionViewCell
        
        let url = Global.imageBaseURL + self.validImages[(indexPath as NSIndexPath).row]
        
        cell.featuredImageView.kf.setImage(with:URL(string: url)!, placeholder: UIImage(named: "placeholder"), options: [.transition(ImageTransition.fade(1))], progressBlock: nil, completionHandler: nil)
        
        return cell
        
    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width * scale,height: (self.view.frame.height - 5*2))
        
    
    }
    
    
}

