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
import SwiftyJSON

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
    
    private func getGitRepositories(user: String) {
        self.aiLoading.startAnimating()
        let url = "https://api.github.com/users/\(user.trim())/repos"
        Alamofire.request(.GET, url)
            .responseJSON { response in switch response.result {
            case .Success(let data):
                let json = JSON(data)
                self.txtGitResults.text = "Lista de repositórios:\n\n"
                json.forEach({ (result, json) in
                    self.txtGitResults.text =  "\(self.txtGitResults.text)\n \(json["name"].stringValue)"
                })
                self.aiLoading.stopAnimating()
                self.view.endEditing(true)
            case .Failure(let error):
                self.txtGitResults.text = "Request failed with error: \(error)"
                }
                self.aiLoading.stopAnimating()
        }
    }
    
    @IBAction func doBack(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    @IBAction func doGet(sender: AnyObject) {
        if self.txtGitUser.text != "" {
            self.getGitRepositories(self.txtGitUser.text!)
        } else {
            self.txtGitResults.text = "*usuário necessário"
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
