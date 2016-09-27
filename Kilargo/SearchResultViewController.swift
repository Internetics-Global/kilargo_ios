//
//  SearchResultViewController.swift
//  Kilargo
//
//  Created by Internetics on 28/04/2016.
//  Copyright © 2016 com.internetics. All rights reserved.
//

import Foundation
import UIKit

class SearchResultViewController:BaseViewController,UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cancelButton: UIButton!
    
    var searchResults:[Product] = []
    
    let SearchResultCell_ID = "SearchResultCell_ID"

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self

        
        cancelButton.addTarget(self, action: #selector(cancelButtonClicke(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.navigationController?.navigationBarHidden = true
        
        tableView.registerNib(UINib(nibName: "SearchResultCell", bundle: nil), forCellReuseIdentifier: SearchResultCell_ID)
        
        
        
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated);
        
        self.searchBar.becomeFirstResponder();
    }
    
    
    func cancelButtonClicke(sender:UIButton) {
        
        let transition = CATransition()
        transition.duration = 0.5;
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionFromTop;
        self.navigationController?.view.layer.addAnimation(transition, forKey: nil)
        self.navigationController?.popViewControllerAnimated(false)
       
        
    }
    
    // MARK: - UITableView
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1;
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70;
    }

    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)

        
        let storyboard : UIStoryboard = UIStoryboard(
            name: "Main",
            bundle: nil)
        let viewController = storyboard.instantiateViewControllerWithIdentifier("ProductViewController") as! ProdutViewController
        let selecteProduct = self.searchResults[indexPath.row];
        viewController.products = [selecteProduct]
        self.navigationController?.pushViewController(viewController, animated: true)
        
        var array = self.navigationController?.viewControllers
        array?.removeAtIndex((array?.count)! - 2)
        self.navigationController?.viewControllers = array!
        
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchResults.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell =
            tableView.dequeueReusableCellWithIdentifier(SearchResultCell_ID, forIndexPath: indexPath)as! SearchResultCell
        
        let product = self.searchResults[indexPath.row]
        
        cell.categoryLabel.text = "\(product.category)->\(product.subcategory)"
        cell.productNameLabel.text = product.productName;
        
        cell.categoryLabel.lineBreakMode = .ByTruncatingHead
        cell.productNameLabel.lineBreakMode = .ByTruncatingHead

        
        return cell;
        
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    
    // MARK: - UISearchBarDelegate
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.searchResults = JsonFetcher.getProductsWithAnyKeyword(searchText)
        
        refreshList()
        
    }
    
    func refreshList() {
        self.tableView.reloadData()
        
    }
    
    
    
}
