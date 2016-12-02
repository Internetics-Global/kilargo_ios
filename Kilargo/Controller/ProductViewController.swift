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

class ProdutViewController: BaseViewController,UIPopoverPresentationControllerDelegate,UIScrollViewDelegate {
    
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    
    fileprivate let scrollWidth: CGFloat = UIScreen.main.bounds.size.width - 40
    
    
    fileprivate var scrollView  : UIScrollView!
    fileprivate var leftArrow   : UIImageView!
    fileprivate var rightArrow  : UIImageView!
    
    var products     :[Product] = []
    
    @IBOutlet weak var productName: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self;
        
        self.setupNotHomeNavigationBar()
        
        self.infoButton.addTarget(self, action: #selector(ProdutViewController.infoButtonClicked), for: UIControlEvents.touchUpInside)
        
        if (self.products.count > 0) {
            self.productName.text = "\(self.products[0].productName) - \(self.products[0].systemNumber)"
        }
        
        setupScrollView()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.searchBar.text = Global.lastSearchKeyword
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        searchBar.resignFirstResponder()
    }
    
    
    func productImageTapped(_ recognizer:UITapGestureRecognizer) {
        
        let index = recognizer.view?.tag
       
        let storyboard : UIStoryboard = UIStoryboard(
            name: "Main",
            bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "CarouselImageViewController") as! CarouselImageViewController
        viewController.product = self.products[index!]
        self.present(viewController, animated: true, completion: nil)

    }
    
    @IBAction func installationButtonClicked(_ sender: AnyObject) {
        
        let page = Int(scrollView.contentOffset.x / scrollView.frame.size.width);
        
        let storyboard : UIStoryboard = UIStoryboard(
            name: "Main",
            bundle: nil)
        let popoverViewController = storyboard.instantiateViewController(withIdentifier: "ProductDesViewController") as! ProductDesViewController
        popoverViewController.product = products[page]
        popoverViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        popoverViewController.view.backgroundColor = UIColor.clear
        popoverViewController.source = .installation
        popoverViewController.modalTransitionStyle = .crossDissolve
        self.present(popoverViewController, animated: true, completion: nil)
        
    }
    
    func infoButtonClicked() {
        
        let page = Int(scrollView.contentOffset.x / scrollView.frame.size.width);
        
        let storyboard : UIStoryboard = UIStoryboard(
            name: "Main",
            bundle: nil)
        let popoverViewController = storyboard.instantiateViewController(withIdentifier: "ProductDesViewController") as! ProductDesViewController
        popoverViewController.product = products[page]
        popoverViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        popoverViewController.view.backgroundColor = UIColor.clear
        popoverViewController.source = .information
        popoverViewController.modalTransitionStyle = .crossDissolve
        self.present(popoverViewController, animated: true, completion: nil)
        
        
    }
    
    func setupScrollView() {
        
        let SCROLL_ITEM_SIZE = self.products.count
        
        self.scrollView = UIScrollView()
        self.scrollView.isPagingEnabled = true
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.delegate = self;
//        self.scrollView.backgroundColor = UIColor.redColor()
        self.view.addSubview(self.scrollView)
        self.scrollView.snp.makeConstraints { (make) in
            make.width.equalTo(scrollWidth)
            make.bottom.equalTo(self.view).offset(-20)
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.productName.snp.bottom)
    
        }
        
        self.leftArrow = UIImageView(image: UIImage(named: "left_arrow_black_scrollview"))
        self.view.addSubview(self.leftArrow)
        self.leftArrow.snp.makeConstraints { (make) in
            make.width.equalTo(12)
            make.height.equalTo(24)
            make.centerY.equalTo(self.scrollView)
            make.left.equalTo(self.scrollView).offset(-15)
        }
        
        self.rightArrow = UIImageView(image: UIImage(named: "right_arrow_black_scrollview"))
        self.view.addSubview(self.rightArrow)
        self.rightArrow.snp.makeConstraints { (make) in
            make.width.equalTo(12)
            make.height.equalTo(24)
            make.centerY.equalTo(self.scrollView)
            make.left.equalTo(self.scrollView.snp.right).offset(3)
        }
        
        
        //scrollView内部子控件的尺寸不能以scrollView的尺寸为参照，见http://cdn0.jianshu.io/p/3429ac5a4e4d，这个很重要，否则会出现问题
        
        let contentView = UIView()
        self.scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.bottom.equalTo(self.view).offset(-10)
            make.left.equalTo(0)
            make.right.equalTo(CGFloat(SCROLL_ITEM_SIZE) * scrollWidth)
        }
//        contentView.backgroundColor = UIColor.greenColor()
        
        var lastView:UIView?
        for index in 0..<SCROLL_ITEM_SIZE {
            
            var imageView = UIImageView()
            imageView.tag = index
            var url = Global.imageBaseURL + products[index].image1
            if (url.contains(".png") || url.contains(".jpg") || url.contains(".jpeg")) {
                
            } else {
                url = url + ".png";
            }
            
            if (url.contains("NO DRAWING")) {
                print("test")
            }
            
            let escapedURL:String? = url.addingPercentEscapes(using: .utf8)
            
            imageView.kf.indicatorType = .activity
            imageView.kf.setImage(with:URL(string: escapedURL!)!, placeholder: nil, options: [.transition(ImageTransition.fade(0.3))], progressBlock: nil, completionHandler: { (image, error, cacheType, finalUrl) in
                if let error = error {
                    print("Error to show image with code = \(error.userInfo), url = \(url)")
                    
                    imageView.image = UIImage(named: "loading_error")
                    imageView.contentMode = .center
                }
            })
            imageView.contentMode = UIViewContentMode.scaleAspectFit

            
            contentView.addSubview(imageView)
            
            
            imageView.snp.makeConstraints { (make) -> Void in
                imageView.snp.makeConstraints({ (make) in
                    make.top.equalTo(contentView).offset(0)
                    make.bottom.equalTo(contentView).offset(0)
                    make.width.equalTo(scrollWidth);
                    if (lastView == nil) {
                        make.left.equalTo(contentView).offset(0)
                    } else {
                        make.left.equalTo(lastView!.snp.right).offset(0)
                    }
            
                })
                
            }
            
            let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(ProdutViewController.productImageTapped))
            imageView.isUserInteractionEnabled = true
            imageView.addGestureRecognizer(tapGestureRecognizer)

            
            lastView = imageView
            
        }
        

        scrollView.contentSize = CGSize(width: CGFloat(SCROLL_ITEM_SIZE) * scrollWidth, height: 320)
        
    
    }
    
    
    
    // MARK: - UIScrollViewDelegate
    
    func getCurrentPage(_ scrollView: UIScrollView) -> (Int) {
        let page = scrollView.contentOffset.x / scrollView.frame.size.width;
        return Int(page);
    
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        updateScrollViewArrowsVisiblity()
        
        let page = self.getCurrentPage(scrollView)
        
        self.productName.text = "\(self.products[page].productName) - \(self.products[page].systemNumber)"
        
        
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
    
    
    override func viewDidLayoutSubviews() {
        
        //在viewDidLoad中，view的尺寸可能还是0，因为还没有计算，autolayout这个属性越来越同android类似了
        updateScrollViewArrowsVisiblity()
    }

    
}

extension ProdutViewController:UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        
        if let searchText = searchBar.text {
            self.showSearchResultDropDown(searchBar: searchBar, searchText: searchText)
        }
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.showSearchResultDropDown(searchBar: searchBar, searchText: searchText)
        
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = nil
        searchBar.resignFirstResponder()
    }
}
