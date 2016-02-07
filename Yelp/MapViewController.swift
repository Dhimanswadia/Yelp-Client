//
//  MapViewController.swift
//  Yelp
//
//  Created by Dhiman on 2/6/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    @IBOutlet weak var mapYelp: MKMapView!
    var businessArray:[Business]!
    var locationManager : CLLocationManager!
    var businesses: [Business]!
    var business: Business!




    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.distanceFilter = 200
        locationManager.requestWhenInUseAuthorization()
        
        mapYelp.delegate = self
        
    }

    
    
    

              // Do any additional setup after loading the view.
    

    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.AuthorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let span = MKCoordinateSpanMake(0.1, 0.1)
            let region = MKCoordinateRegionMake(location.coordinate, span)
            mapYelp.setRegion(region, animated: false)
        }
    }
    
    func addAnnotationAtCoordinate(business: Business) {
     //   let coordinate = business.coordinate
        let annotation = MKPointAnnotation()
     //   annotation.coordinate = coordinate!
        annotation.title = business.name
        mapYelp.addAnnotation(annotation)
    }
    func setupAnnotations() {
        for business in businesses {
            addAnnotationAtCoordinate(business)
        }
    }

    
    func goToLocation(location: CLLocation) {
        let span = MKCoordinateSpanMake(0.1, 0.1)
        let region = MKCoordinateRegionMake(location.coordinate, span)
        mapYelp.setRegion(region, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
