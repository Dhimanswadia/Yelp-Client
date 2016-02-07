//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate, UIScrollViewDelegate, FiltersViewControllerDelegate{
    @IBOutlet weak var filter: UIButton!

    @IBOutlet weak var yELpView: UITableView!
    var businesses: [Business]!
    var searchBarButtonItem: UIBarButtonItem?
    
    @IBAction func goToMap(sender: AnyObject) {
         self.performSegueWithIdentifier("gotoMap", sender: self)
    }
    @IBOutlet weak var mapButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        yELpView.delegate = self
        yELpView.dataSource = self
        yELpView.rowHeight = UITableViewAutomaticDimension
        yELpView.estimatedRowHeight = 120
        let searchBar = UISearchBar()
        searchBar.delegate = self
        self.navigationItem.titleView = searchBar
        searchBar.showsCancelButton = true;
        navigationItem.setLeftBarButtonItem(mapButton, animated: true)


        Business.searchWithTerm("Thai", completion: { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            self.yELpView.reloadData()
        
            for business in businesses {
                print(business.name!)
                print(business.address!)
            }
        })

/* Example of Yelp search with more search options specified
        Business.searchWithTerm("Restaurants", sort: .Distance, categories: ["asianfusion", "burgers"], deals: true) { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            
            for business in businesses {
                print(business.name!)
                print(business.address!)
            }
        }
*/
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if businesses != nil {
            return businesses.count
        } else {
            return 0
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = yELpView.dequeueReusableCellWithIdentifier("BussinessCell",forIndexPath: indexPath) as! BussinessCell
        cell.business = businesses[indexPath.row]
        
        return cell
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        Business.searchWithTerm(searchText, completion: { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            self.yELpView.reloadData()
            
            for business in businesses {
                print(business.name!)
                print(business.address!)
            }
        })
    }
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.text = ""
        yELpView.reloadData()
        searchBar.resignFirstResponder()
    }
    var isMoreDataLoading = false
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if (!isMoreDataLoading) {
            // Calculate the position of one screen length before the bottom of the results
            let scrollViewContentHeight = yELpView.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - yELpView.bounds.size.height
                        if(scrollView.contentOffset.y > scrollOffsetThreshold && yELpView.dragging) {
                            print("greg")
                
                isMoreDataLoading = true
                            self.yELpView.reloadData()
                          
                
                            }
        }
    }
    

   

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let navigationController = segue.destinationViewController as! UINavigationController
        
        let filtersViewControler = navigationController.topViewController as! FiltersViewController
        
       filtersViewControler.delegate = self
    }
    
    func filtersViewController(filterViewController: FiltersViewController, didUpdateFilters filters: [String : AnyObject]) {
        
        var catergories = filters["catergories"] as? [String]
        
        Business.searchWithTerm("", sort: nil, categories: catergories, deals: nil) { (businesses: [Business]!, error: NSError!) -> Void in
            
            self.businesses = businesses
            
            self.yELpView.reloadData()
            
        }
        
    }

    


    

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//    let map1 = segue.destinationViewController as! MapViewController
//    map1.businessArray = self.businesses as AnyObject as! [Business]
//
//    }
//

}
