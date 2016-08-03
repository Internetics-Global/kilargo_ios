//
//  ProductViewController.swift
//  Kilargo
//
//  Created by Internetics on 23/04/2016.
//  Copyright © 2016 com.internetics. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import Kingfisher

class ProdutViewController: UIViewController,UIPopoverPresentationControllerDelegate,UIScrollViewDelegate,UISearchBarDelegate {
    
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private let scrollWidth: CGFloat = UIScreen.mainScreen().bounds.size.width - 40
    private let scrollHeight:CGFloat = 350
    
    
    private var scrollView  : UIScrollView!
    private var leftArrow   : UIImageView!
    private var rightArrow  : UIImageView!
    
    var products     :[Product] = []
    
    @IBOutlet weak var productName: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self;
        
        self.navigationController?.navigationBarHidden = false
        
        self.infoButton.addTarget(self, action: #selector(ProdutViewController.infoButtonClicked), forControlEvents: UIControlEvents.TouchUpInside)
        
        if (self.products.count > 0) {
            self.productName.text = self.products[0].productName
        }
        
        setupScrollView()
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBarHidden = false
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        searchBar.resignFirstResponder()
    }
    
    
    func productImageTapped(recognizer:UITapGestureRecognizer) {
        
        let index = recognizer.view?.tag
       
        let storyboard : UIStoryboard = UIStoryboard(
            name: "Main",
            bundle: nil)
        let viewController = storyboard.instantiateViewControllerWithIdentifier("CarouselImageViewController") as! CarouselImageViewController
        viewController.product = self.products[index!]
        self.presentViewController(viewController, animated: true, completion: nil)

    }
    
    func infoButtonClicked() {
        
        let page = Int(scrollView.contentOffset.x / scrollView.frame.size.width);
        
        let storyboard : UIStoryboard = UIStoryboard(
            name: "Main",
            bundle: nil)
        let popoverViewController = storyboard.instantiateViewControllerWithIdentifier("ProductDesViewController") as! ProductDesViewController
        popoverViewController.product = products[page]
        popoverViewController.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
        popoverViewController.anchorPoint = CGPointMake(CGRectGetWidth(self.view.frame)/2, CGRectGetMidY(self.scrollView.frame))
        popoverViewController.view.backgroundColor = UIColor.clearColor()
        self.presentViewController(popoverViewController, animated: true, completion: nil)
        
        
        
        
        
    }
    
    func setupScrollView() {
        
        let SCROLL_ITEM_SIZE = self.products.count
        
        self.scrollView = UIScrollView()
        self.scrollView.pagingEnabled = true
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.delegate = self;
        self.view.addSubview(self.scrollView)
        self.scrollView.snp_makeConstraints { (make) in
            make.width.equalTo(scrollWidth)
            make.height.equalTo(scrollHeight)
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.infoButton.snp_bottom)
    
        }
        
        self.leftArrow = UIImageView(image: UIImage(named: "left_arrow"))
        self.view.addSubview(self.leftArrow)
        self.leftArrow.snp_makeConstraints { (make) in
            make.width.equalTo(10)
            make.height.equalTo(20)
            make.centerY.equalTo(self.scrollView)
            make.left.equalTo(self.scrollView).offset(-10)
        }
        
        self.rightArrow = UIImageView(image: UIImage(named: "right_arrow"))
        self.view.addSubview(self.rightArrow)
        self.rightArrow.snp_makeConstraints { (make) in
            make.width.equalTo(10)
            make.height.equalTo(20)
            make.centerY.equalTo(self.scrollView)
            make.left.equalTo(self.scrollView.snp_right).offset(0)
        }
        
        
        //scrollView内部子控件的尺寸不能以scrollView的尺寸为参照，见http://cdn0.jianshu.io/p/3429ac5a4e4d，这个很重要，否则会出现问题
        
        let contentView = UIView()
        self.scrollView.addSubview(contentView)
        contentView.snp_makeConstraints { (make) in
            make.top.equalTo(0)
            make.height.equalTo(scrollHeight)
            make.left.equalTo(0)
            make.right.equalTo(CGFloat(SCROLL_ITEM_SIZE) * scrollWidth)
        }
        //contentView.backgroundColor = UIColor.greenColor()
        
        var lastView:UIView?
        for index in 0..<SCROLL_ITEM_SIZE {
            
            let imageView = UIImageView()
            imageView.tag = index
            let url = Global.imageBaseURL + products[index].productImage
            imageView.kf_setImageWithURL(NSURL(string: url)!, placeholderImage: UIImage(named: "placeholder"), optionsInfo: [.Transition(ImageTransition.Fade(1))], progressBlock: nil, completionHandler: nil)
            imageView.contentMode = UIViewContentMode.ScaleAspectFit
            
            contentView.addSubview(imageView)
            
            
            imageView.snp_makeConstraints { (make) -> Void in
                imageView.snp_makeConstraints(closure: { (make) in
                    make.top.equalTo(contentView).offset(0)
                    make.bottom.equalTo(contentView).offset(0)
                    make.width.equalTo(scrollWidth);
                    if (lastView == nil) {
                        make.left.equalTo(contentView).offset(0)
                    } else {
                        make.left.equalTo(lastView!.snp_right).offset(0)
                    }
            
                })
                
            }
            
            let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(ProdutViewController.productImageTapped))
            imageView.userInteractionEnabled = true
            imageView.addGestureRecognizer(tapGestureRecognizer)

            
            lastView = imageView
            
        }
        

        scrollView.contentSize = CGSizeMake(CGFloat(SCROLL_ITEM_SIZE) * scrollWidth, scrollHeight)
        
    
    }
    
    // MARK: - UISearchBarDelegate
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        let storyboard : UIStoryboard = UIStoryboard(
            name: "Main",
            bundle: nil)
        let viewController = storyboard.instantiateViewControllerWithIdentifier("SearchResultViewController") as! SearchResultViewController
        let transition = CATransition()
        transition.duration = 0.5;
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionFromBottom;
        self.navigationController?.view.layer.addAnimation(transition, forKey: nil)
        self.navigationController?.pushViewController(viewController, animated: false)
    }
    
    
    // MARK: - UIScrollViewDelegate
    
    func getCurrentPage(scrollView: UIScrollView) -> (Int) {
        let page = scrollView.contentOffset.x / scrollView.frame.size.width;
        return Int(page);
    
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        updateScrollViewArrowsVisiblity()
        
        let page = self.getCurrentPage(scrollView)
        
        self.productName.text = self.products[page].productName
        
        
    }
    
    func updateScrollViewArrowsVisiblity() {
        
        let scrollViewWidth = CGRectGetWidth(scrollView.frame);
        let scrollContentSizeWidth = scrollView.contentSize.width;
        let scrollOffset = scrollView.contentOffset.x;
        
        if (scrollView.contentOffset.x <= 0) {
            self.leftArrow.hidden = true;
        } else {
            self.leftArrow.hidden = false;
        }
        
        if (scrollOffset + scrollViewWidth >= scrollContentSizeWidth) {
            self.rightArrow.hidden = true;
        } else {
            self.rightArrow.hidden = false;
        }
    }
    
    
    override func viewDidLayoutSubviews() {
        
        //在viewDidLoad中，view的尺寸可能还是0，因为还没有计算，autolayout这个属性越来越同android类似了
        updateScrollViewArrowsVisiblity()
    }

    
}
