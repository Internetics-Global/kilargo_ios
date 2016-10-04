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
        
        self.collectionView.isPagingEnabled = true

        
    }
    
    fileprivate struct Storyboard {
        static let CellIdentifier = "CarouselCellIdentifier"
    }
    
    
    @IBAction func closeButtonClicked(_ sender: AnyObject) {
        
        self.dismiss(animated: true, completion: nil)
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

extension CarouselImageViewController:UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewController = ZoomImageViewController()
        viewController.imageUrl = Global.imageBaseURL + self.validImages[(indexPath as NSIndexPath).row]
        viewController.modalTransitionStyle = .crossDissolve
        self.present(viewController, animated: true, completion: nil)
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
        return CGSize(width: self.view.frame.width,height: (self.view.frame.height - 5*2))
        
    
    }
    
    
}

