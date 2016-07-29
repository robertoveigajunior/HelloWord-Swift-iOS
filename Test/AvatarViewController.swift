//
//  AvatarViewController.swift
//  Test
//
//  Created by Roberto Veiga Junior on 28/07/16.
//  Copyright © 2016 RJR. All rights reserved.
//

import UIKit
import Crashlytics

class AvatarViewController: UIViewController {
    
    @IBOutlet weak var imgAvatar: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Answers.logContentViewWithName("Tweet", contentType: "Video", contentId: "1234", customAttributes: ["Favorites Count":20, "Screen Orientation":"Landscape"])
    }
    
    private func openCamera() {
    
    }
    
    private func nextPage() {
        
    }
    
    @IBAction func tapOnAvatar(sender: AnyObject) {
        self.openCamera()
    }
    
    @IBAction func doNext(sender: UIButton) {
        self.nextPage()
    }
    
}
