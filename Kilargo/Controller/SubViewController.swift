//
//  SubViewController.swift
//  Kilargo
//
//  Created by Internetics on 26/04/2016.
//  Copyright © 2016 com.internetics. All rights reserved.
//

import Foundation
import UIKit

class SubViewController:BaseViewController{
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    fileprivate var subCategories:[SubCategory] = []
    fileprivate var selectedMenuListIndex = -1
    
    var parentCategoryID:Int  = 0 {
        didSet {
           subCategories = JsonFetcher.getSubcategory(parentCategoryID)
        }
    }
    
    
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableview.delegate = self
        self.tableview.dataSource = self;

        self.searchBar.delegate = self;
        
        refreshList()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.searchBar.text = Global.lastSearchKeyword
        
        self.setupNotHomeNavigationBar()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        searchBar.resignFirstResponder()
        super.removeAllSubviewsFromNavigationBar()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let selectedSubCategory:SubCategory = self.subCategories[selectedMenuListIndex];
        
        if (segue.destination is ProdutViewController) {
            (segue.destination as! ProdutViewController).products = JsonFetcher.getProducts(categoryId: parentCategoryID, subCategoryId: selectedSubCategory.subcategoryID)
            
        }
        
    }
    
    func refreshList() {
        self.tableview.reloadData()
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

extension SubViewController:UISearchBarDelegate {
    
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

extension SubViewController:UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.subCategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SubMenuItemCell.identifier, for: indexPath) as! SubMenuItemCell
        cell.titleLabel.text = self.subCategories[(indexPath as NSIndexPath).row].subcategoryName
        //        cell.backgroundColor = UIColor.greenColor()
        
        cell.accessoryView = UIImageView(image: UIImage(named: "right_arrow_white"))
        
        return cell;
        
    }
    
}

extension SubViewController:UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44;
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        selectedMenuListIndex = (indexPath as NSIndexPath).row
        return indexPath
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
}
