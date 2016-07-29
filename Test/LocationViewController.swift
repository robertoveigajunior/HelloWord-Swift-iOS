//
//  RecorderViewController.swift
//  Test
//
//  Created by Roberto Luiz Veiga Junior on 29/07/16.
//  Copyright © 2016 RJR. All rights reserved.
//

import UIKit
import MapKit

class LocationViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var imgPin: UIImageView!
    @IBOutlet weak var btEnd: UIButton!
    
    @IBOutlet weak var aiLoading: UIActivityIndicatorView!
    var avatar: UIImage!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initCommon()
    }
    
    private func imageRadius() {
        self.imgAvatar.layer.cornerRadius = self.imgAvatar.frame.width/2
        self.imgAvatar.layer.masksToBounds = true
        self.imgPin.layer.cornerRadius = self.imgPin.frame.width/2
        self.imgPin.layer.masksToBounds = true
        self.imgAvatar.setBorderSlim
        self.imgPin.setBorder
    }
    
    private func initCommon() {
        self.btEnd.hidden = true
        self.imgAvatar.image = self.avatar
        self.imageRadius()
        self.askAuthorization()
    }
    
    private func askAuthorization() {
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            self.aiLoading.startAnimating()
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        self.btEnd.hidden = false
        self.locationManager.stopUpdatingLocation()
        self.aiLoading.stopAnimating()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let view = segue.destinationViewController as! EndViewController
        view.location = sender! as! String
    }
    
    @IBAction func doBack(sender: UIButton) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    @IBAction func doDone(sender: UIButton) {
        self.performSegueWithIdentifier("sgEnd", sender: String(self.locationManager.location))
    }
    
    @IBAction func doLocation(sender: AnyObject) {
        self.locationManager.startUpdatingLocation()
    }
    
}
