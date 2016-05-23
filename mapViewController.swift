//
//  mapViewController.swift
//  Alzheimer
//
//  Created by Fahn on 5/19/16.
//  Copyright © 2016 Fahn. All rights reserved.
//

import UIKit
import MapKit

class mapViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var theMapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()

        var latitude:CLLocationDegrees = 13.870624
        var longitude:CLLocationDegrees = 100.552698
        
        var laDelta:CLLocationDegrees = 0.01
        var longDelta:CLLocationDegrees = 0.01
        
        var theSpan:MKCoordinateSpan = MKCoordinateSpanMake(laDelta, longDelta)
        var dpuLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        var theRegion:MKCoordinateRegion = MKCoordinateRegionMake(dpuLocation, theSpan)
        
        self.theMapView.setRegion(theRegion, animated: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //ทำให้หน้าจอแอพเป็นแนวตั้งอย่างเดียว
    override func shouldAutorotate() -> Bool {
        return false
    }
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }
    

}
