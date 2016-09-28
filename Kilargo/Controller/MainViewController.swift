//
//  ViewController.swift
//  Kilargo
//
//  Created by Internetics on 22/04/2016.
//  Copyright © 2016 com.internetics. All rights reserved.
//

import UIKit
import Refresher
import ReachabilitySwift
import SCLAlertView
import SlideMenuControllerSwift
import DropDown

class MainViewController: BaseViewController, UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {
    
//todo
//    private static var __once: () = { [unowned self] in
//            self.openLeftMenuList()
//        }()
    

    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    fileprivate var categories:[String] = []
    fileprivate var selectedMenuListIndex = -1
    
    fileprivate let TABLE_CELL_ID_SET_IN_B = "TableCellID"
    
    fileprivate var pullRefreshShowing = false
    
    fileprivate var reachability: Reachability!
    
    fileprivate var onlyOnce = true

    
    // MARK: - Life cycle
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.statusBarStyle = .default
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        self.tableview.delegate = self
        self.tableview.dataSource = self;
        
        let pullToRefreshBeatAnimator = PullToRefreshBeatAnimator(frame: CGRect(x: 0, y: 0, width: 320, height: 30))
        self.tableview.addPullToRefreshWithAction({
            self.pullRefreshShowing = true
            self.fetchData()
        },withAnimator: pullToRefreshBeatAnimator)
    

        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidBecomeActiveNotification), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
        

        setupReachability()
        
        self.searchBar.delegate = self;
        
        fetchData()


    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setupNotHomeNavigationBar()
        
        let dispatchTime: DispatchTime = DispatchTime.now() + Double(Int64(0.1 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: dispatchTime, execute: { [unowned self] in
            
            self.setupLeftMenuNavigationBarItem()
            let rightBarbuttonItem: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(self.refresh))
            self.navigationItem.rightBarButtonItem = rightBarbuttonItem;
            
        })
            
        
        
        self.searchBar.text = nil
        
//        _ = MainViewController.__once
        //todo
        
        if (onlyOnce) {
            onlyOnce = false
            self.openLeftMenuList()
        }
        
    }
    

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        searchBar.resignFirstResponder()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = (segue.destination as? SubViewController) {
           viewController.parentCategoryName = self.categories[selectedMenuListIndex]
        }
    }
    
    // MARK: - Actions
    
    fileprivate func setupReachability() {
        
        reachability = Reachability()
        
        
        reachability.whenReachable = { reachability in
            // this is called on a background thread, but UI updates must
            // be on the main thread, like this:
            DispatchQueue.main.async {
                if reachability.isReachableViaWiFi {
                    print("Reachable via WiFi")
                } else {
                    print("Reachable via Cellular")
                }
            }
        }
        reachability.whenUnreachable = { reachability in
            // this is called on a background thread, but UI updates must
            // be on the main thread, like this:
            DispatchQueue.main.async {
                print("Not reachable")
                
                SCLAlertView().showWarning("Alert", subTitle: "No internet connection")
                
            }
        }
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    fileprivate func pullRefresh() {
        fetchData()
    }
    
    func refresh() {
        fetchData()
    }
    
    
    fileprivate func fetchData() {
        
        if (pullRefreshShowing == false) {
            DispatchQueue.main.async(execute: {
                self.navigationController?.startAnimating(CGSize(width: 60, height: 60), message: "Loading...", type: .lineScalePulseOut, color: UIColor.white, padding: 0)
            })
        }
        
        
        DispatchQueue.global(qos: DispatchQoS.QoSClass.background).async(execute: {
            
            JsonFetcher.fetchProducts(Global.feedURL) { (result, errorMessage) in
                
                DispatchQueue.main.async(execute: {
                    
                    if (self.pullRefreshShowing == false) {
                        self.navigationController!.stopAnimating()
                    } else {
                        self.tableview.stopPullToRefresh()
                        self.pullRefreshShowing = false;
                    }
                    
                    if (result) {
                        
                        self.refreshList()
                        
                    } else {
                        
                        NSLog(errorMessage)
                        let friendlyErrorMessage = "Fail to fetch data, please try again"
                        
                        SCLAlertView().showWarning("Alert", subTitle: friendlyErrorMessage)
                        
                        
                    }
                    
                })
            }
            
        })
        
    }
    
    
    fileprivate func refreshList() {
        self.categories = JsonFetcher.getCategory()
        self.tableview.reloadData()
        
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.showSearchResultDropDown(searchBar: searchBar, searchText: searchText)
        
    }
    
    
    
    // MARK: - UITableView
    
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TABLE_CELL_ID_SET_IN_B, for: indexPath) as! MenuItemCell
        
        cell.titleLabel.text = self.categories[(indexPath as NSIndexPath).row]
        
        return cell;
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    // MARK: - UIApplicationDidBecomeActiveNotification
    func applicationDidBecomeActiveNotification(_ notification:Notification) {
        fetchData()
    }
    
    
    
    // MARK: - Memory managment
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    deinit {
        if (reachability != nil) {
            reachability .stopNotifier()
        }
        NotificationCenter.default.removeObserver(self)
    }
    


}

private struct Static {
    static var token: Int = 0
}



