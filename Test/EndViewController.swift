//
//  EndViewController.swift
//  Test
//
//  Created by Roberto Luiz Veiga Junior on 29/07/16.
//  Copyright © 2016 RJR. All rights reserved.
//

import UIKit
import MapKit
import Alamofire

class EndViewController: UIViewController {

    @IBOutlet weak var aiLoading: UIActivityIndicatorView!
    @IBOutlet weak var txtGitResults: UITextView!
    @IBOutlet weak var lbLocations: UILabel!
    @IBOutlet weak var imgGitAvatar: UIImageView!
    @IBOutlet weak var txtGitUser: UITextField!
    
    var location: CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lbLocations.text = "Latitude: \(self.location.coordinate.latitude) - Longitude: \(self.location.coordinate.longitude)"
    }
    
    private func getGitRepositoryes(user: String) {
        self.aiLoading.startAnimating()
        let url = "https://api.github.com/users/\(user)/repos"
        Alamofire.request(.GET, url)
            .responseJSON { response in
                self.aiLoading.stopAnimating()
                self.txtGitResults.text = String(response.response!)
            }
            .responseString { response in
                // print response as string for debugging, testing, etc.
                print(response.result.value)
                print(response.result.error)
        }
    }

    @IBAction func doBack(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    @IBAction func doGet(sender: AnyObject) {
        if self.txtGitUser.text != "" {
            self.getGitRepositoryes(self.txtGitUser.text!)
        } else {
            self.txtGitResults.text = "*usuário necessário"
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
