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
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    fileprivate var leftArrow   : UIImageView!
    fileprivate var rightArrow  : UIImageView!
    
    fileprivate var validImages:[String] = []
    
    fileprivate static let SUB_SCROLLVIEW_TAG_BASE = 1000
    fileprivate static let MAIN_SCROLLVIEW_TAG = 0
    
    fileprivate var currentPage:Int = 0
    
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
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        KingfisherManager.shared.cache.clearMemoryCache()
//        KingfisherManager.shared.cache.clearDiskCache()
        
        self.scrollView.isPagingEnabled = true
        self.scrollView.delegate = self
        self.scrollView.tag = CarouselImageViewController.MAIN_SCROLLVIEW_TAG
        self.scrollView.maximumZoomScale = 1
        self.scrollView.minimumZoomScale = 1
        
        //self.scrollView.backgroundColor = UIColor.red
        
        let COUNT = validImages.count
        let scrollViewWidth: CGFloat = max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height)
        let scrollViewHeight: CGFloat = min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height) - 10*2
        
        var i = 0
        while (i < COUNT) {
            
            let pageScrollView = UIScrollView()
            //scrollView.backgroundColor = UIColor.red
            pageScrollView.maximumZoomScale = 5
            pageScrollView.minimumZoomScale = 1
            pageScrollView.delegate = self;
            pageScrollView.tag = i + CarouselImageViewController.SUB_SCROLLVIEW_TAG_BASE
            pageScrollView.bounces = false
            self.scrollView.addSubview(pageScrollView)
            pageScrollView.snp.makeConstraints { (make) in
                make.left.equalTo(scrollViewWidth * CGFloat(i))
                make.top.equalTo(0)
                make.width.equalTo(scrollViewWidth)
                make.height.equalTo(scrollViewHeight)
            }
            
            var imageView = UIImageView()
            pageScrollView.addSubview(imageView)
            imageView.snp.makeConstraints { (make) in
                make.center.equalToSuperview()
                make.width.equalTo(scrollViewWidth)
                make.height.equalTo(scrollViewHeight)
            }
            //imageView.backgroundColor = UIColor.orange
            imageView.contentMode = .scaleAspectFit
            
            var url = Global.imageBaseURL + self.validImages[i]
            if (url.contains(".png") || url.contains(".jpg") || url.contains(".jpeg")) {
                
            } else {
                url = url + ".png";
            }
            
            imageView.kf.indicatorType = .activity
            (imageView.kf.indicator?.view as! UIActivityIndicatorView).color = UIColor.white
            imageView.kf.setImage(with:URL(string: url)!, placeholder: nil, options: [.transition(ImageTransition.fade(0.3))], progressBlock: nil, completionHandler: { (image, error, cacheType, finalUrl) in
                if let error = error {
                    print("Error to show image with code = \(error.userInfo), url = \(url)")
                }
            })
            
            
            i = i + 1
            
//            if (i%2 == 0) {
//                imageView.backgroundColor = UIColor.orange
//            }else {
//                imageView.backgroundColor = UIColor.red
//            }
            
            let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(self.productImageTapped(_:)))
            imageView.isUserInteractionEnabled = true
            imageView.addGestureRecognizer(tapGestureRecognizer)
            
            
        }
        
        self.scrollView.contentSize = CGSize(width: scrollViewWidth*CGFloat(COUNT), height: scrollViewHeight)

        
        
        self.leftArrow = UIImageView(image: UIImage(named: "left_arrow_gray"))
        self.view.addSubview(self.leftArrow)
        self.leftArrow.snp.makeConstraints { (make) in
            make.width.equalTo(16)
            make.height.equalTo(16)
            make.centerY.equalTo(self.view)
            make.left.equalTo(self.view).offset(0)
        }
        
        self.rightArrow = UIImageView(image: UIImage(named: "right_arrow_gray"))
        self.view.addSubview(self.rightArrow)
        self.rightArrow.snp.makeConstraints { (make) in
            make.width.equalTo(16)
            make.height.equalTo(16)
            make.centerY.equalTo(self.view)
            make.left.equalTo(self.view.snp.right).offset(-16)
        }


        
    }
    
    fileprivate struct Storyboard {
        static let CellIdentifier = "CarouselCellIdentifier"
    }
    
    @objc fileprivate func productImageTapped(_ sender: UITapGestureRecognizer) {
        
        let tappedScrollView = sender.view?.superview as! UIScrollView
        tappedScrollView.zoomScale = 1
        tappedScrollView.contentOffset = CGPoint.zero
        
        
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
    
    func updateScrollViewArrowsVisiblity() {
        
        let scrollViewWidth = scrollView.frame.width;
        let scrollContentSizeWidth = scrollView.contentSize.width;
        let scrollOffset = scrollView.contentOffset.x;
        
        if (scrollView.contentOffset.x <= 0) {
            self.leftArrow.isHidden = true;
        } else {
            self.leftArrow.isHidden = false;
        }
        
        if (scrollOffset + scrollViewWidth >= scrollContentSizeWidth) {
            self.rightArrow.isHidden = true;
        } else {
            self.rightArrow.isHidden = false;
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        updateScrollViewArrowsVisiblity()
        
    }
    
    override func viewDidLayoutSubviews() {
        updateScrollViewArrowsVisiblity()
    }
    
}

extension CarouselImageViewController:UIScrollViewDelegate {
    
    //for scrollivew that holds image
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        for item in self.scrollView.subviews {
            if (item.tag == currentPage + CarouselImageViewController.SUB_SCROLLVIEW_TAG_BASE && item is UIScrollView) {
                return item.subviews.first
            }
        }
        
        return nil;
    }
    
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        if (scrollView.zoomScale > 1) {
            self.scrollView.isScrollEnabled = false
        } else {
            self.scrollView.isScrollEnabled = true
        }
    }
    
    //for the top scrollview, rather than the scrollivew that holds image
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        if (scrollView.tag == CarouselImageViewController.MAIN_SCROLLVIEW_TAG) {
            
            currentPage = Int(scrollView.contentOffset.x / scrollView.frame.size.width);
            
            for item in self.scrollView.subviews {
                if let item = item as? UIScrollView {
                    //print("scrollViewDidEndDecelerating",item)
                    item.zoomScale = 1
                    item.contentOffset = CGPoint.zero
                }
            }
            
        }
        
    }
    
    
    
    
}


