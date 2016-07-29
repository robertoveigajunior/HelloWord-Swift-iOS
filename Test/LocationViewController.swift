//
//  RecorderViewController.swift
//  Test
//
//  Created by Roberto Luiz Veiga Junior on 29/07/16.
//  Copyright © 2016 RJR. All rights reserved.
//

import UIKit
import MapKit
import Crashlytics


class LocationViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var imgPin: UIImageView!
    @IBOutlet weak var btEnd: UIButton!
    @IBOutlet weak var lbNote: UILabel!
    @IBOutlet weak var aiLoading: UIActivityIndicatorView!
    var avatar: UIImage!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initCommon()
        self.trackAnswers()
    }
    
    private func trackAnswers() {
        Answers.logContentViewWithName("Tweet", contentType: "Video", contentId: "1234", customAttributes: ["Favorites Count":20, "Screen Orientation":"Landscape"])

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
        self.lbNote.hidden = true
        self.btEnd.hidden = true
        self.imgAvatar.image = self.avatar
        self.imageRadius()
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
        self.btEnd.hidden = false
        self.locationManager.stopUpdatingLocation()
        self.aiLoading.stopAnimating()
        self.lbNote.hidden = false
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let view = segue.destinationViewController as! EndViewController
        view.location = sender as! CLLocation
    }
    
    @IBAction func doBack(sender: UIButton) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    @IBAction func doDone(sender: UIButton) {
        if let str = self.locationManager.location {
            self.performSegueWithIdentifier("sgEnd", sender: str)
        }
    }
    
    @IBAction func doLocation(sender: AnyObject) {
        self.askAuthorization()
    }
    
}
