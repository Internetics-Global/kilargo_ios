//
//  SubViewController.swift
//  Kilargo
//
//  Created by Internetics on 26/04/2016.
//  Copyright © 2016 com.internetics. All rights reserved.
//

import Foundation
import UIKit

class SubViewController:UIViewController, UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var parentCategoryName:String  = ""{
        didSet {
           categories = JsonFetcher.getSubcategoryWithParenent(parentCategoryName)
        }
    }
    
    private var categories:[String] = []
    
    private var selectedMenuListIndex = -1
    
    private let TABLE_CELL_ID_SET_IN_B = "TableCellID"
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableview.delegate = self
        self.tableview.dataSource = self;
        
        self.searchBar.delegate = self;
        
        refreshList()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBarHidden = false
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        searchBar.resignFirstResponder()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.destinationViewController is ProdutViewController) {
            
            (segue.destinationViewController as! ProdutViewController).products = JsonFetcher.getProductsWithSubcategoryName(self.categories[selectedMenuListIndex])
            
        }
    }
    
    
    
    func refreshList() {
        self.tableview.reloadData()
        
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
    
    
    // MARK: - UITableView
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44;
    }
    
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        selectedMenuListIndex = indexPath.row
        return indexPath
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categories.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(TABLE_CELL_ID_SET_IN_B, forIndexPath: indexPath) as! SubMenuItemCell
        cell.titleLabel.text = self.categories[indexPath.row]
        
        return cell;
        
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    
    // MARK: - Memory managment
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}