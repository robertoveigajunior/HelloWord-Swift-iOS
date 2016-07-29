//
//  EndViewController.swift
//  Test
//
//  Created by Roberto Luiz Veiga Junior on 29/07/16.
//  Copyright © 2016 RJR. All rights reserved.
//

import UIKit
import MapKit

class EndViewController: UIViewController {

    @IBOutlet weak var lbLocations: UILabel!
    
    var location: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lbLocations.text = self.location
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
