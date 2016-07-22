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

class MainViewController: UIViewController, UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {
    
    
    @IBOutlet weak var logoImageView: UIImageView!

    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var refreshButton: UIButton!
    
    private var refreshControl: UIRefreshControl!
    
    private var categories:[String] = []
    private var selectedMenuListIndex = -1
    
    private let TABLE_CELL_ID_SET_IN_B = "TableCellID"
    
    private var pullRefreshShowing = false
    
    private var reachability: Reachability!

    
    // MARK: - Life cycle
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableview.delegate = self
        self.tableview.dataSource = self;
        
        self.navigationController?.navigationBarHidden = false
        
        let beatAnimator = PullToRefreshBeatAnimator(frame: CGRectMake(0, 0, 320, 30))
        self.tableview.addPullToRefreshWithAction({
            self.pullRefreshShowing = true
            self.fetchData()
        },withAnimator: beatAnimator)
        
        self.searchBar.delegate = self;
        
        let rightBarbuttonItem: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Refresh, target: self, action: #selector(self.refresh))
        self.navigationItem.rightBarButtonItem = rightBarbuttonItem;
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage.fromColor(UIColor.whiteColor()), forBarPosition: .Any, barMetrics: .Default)
        
        self.navigationController?.navigationBar.shadowImage = UIImage()

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(applicationDidBecomeActiveNotification), name: UIApplicationDidBecomeActiveNotification, object: nil)

        setupReachability()
        
        fetchData()


    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setNavigationBarItem()
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        searchBar.resignFirstResponder()
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let viewController = (segue.destinationViewController as? SubViewController) {
           viewController.parentCategoryName = self.categories[selectedMenuListIndex]
        }
    }
    
    // MARK: - Actions
    
    private func setupReachability() {
        
        do {
            reachability = try Reachability.reachabilityForInternetConnection()
        } catch {
            print("Unable to create Reachability")
            return
        }
        
        
        reachability.whenReachable = { reachability in
            // this is called on a background thread, but UI updates must
            // be on the main thread, like this:
            dispatch_async(dispatch_get_main_queue()) {
                if reachability.isReachableViaWiFi() {
                    print("Reachable via WiFi")
                } else {
                    print("Reachable via Cellular")
                }
            }
        }
        reachability.whenUnreachable = { reachability in
            // this is called on a background thread, but UI updates must
            // be on the main thread, like this:
            dispatch_async(dispatch_get_main_queue()) {
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
    
    private func pullRefresh() {
        fetchData()
    }
    
    func refresh() {
        fetchData()
    }
    
    
    private func fetchData() {
        
        if (pullRefreshShowing == false) {
            dispatch_async(dispatch_get_main_queue(),{
                self.navigationController!.startActivityAnimating("Loading...",type: .LineScalePulseOut)
            })
        }
        
        
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0), {
            
            JsonFetcher.fetchProducts(Global.feedURL) { (result, errorMessage) in
                
                dispatch_async(dispatch_get_main_queue(),{
                    
                    if (self.pullRefreshShowing == false) {
                        self.navigationController!.stopActivityAnimating()
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
    
    
    private func refreshList() {
        self.categories = JsonFetcher.getCategory()
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
        
        let cell = tableView.dequeueReusableCellWithIdentifier(TABLE_CELL_ID_SET_IN_B, forIndexPath: indexPath) as! MenuItemCell
        
        cell.titleLabel.text = self.categories[indexPath.row]
        
        return cell;
        
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    // MARK: - UIApplicationDidBecomeActiveNotification
    func applicationDidBecomeActiveNotification(notification:NSNotification) {
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
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    


}

extension MainViewController : SlideMenuControllerDelegate {
    
    func leftWillOpen() {
        print("SlideMenuControllerDelegate: leftWillOpen")
    }
    
    func leftDidOpen() {
        print("SlideMenuControllerDelegate: leftDidOpen")
    }
    
    func leftWillClose() {
        print("SlideMenuControllerDelegate: leftWillClose")
    }
    
    func leftDidClose() {
        print("SlideMenuControllerDelegate: leftDidClose")
    }
    
    func rightWillOpen() {
        print("SlideMenuControllerDelegate: rightWillOpen")
    }
    
    func rightDidOpen() {
        print("SlideMenuControllerDelegate: rightDidOpen")
    }
    
    func rightWillClose() {
        print("SlideMenuControllerDelegate: rightWillClose")
    }
    
    func rightDidClose() {
        print("SlideMenuControllerDelegate: rightDidClose")
    }
}

