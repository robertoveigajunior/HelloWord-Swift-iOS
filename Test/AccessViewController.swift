//
//  AccessViewController.swift
//  Test
//
//  Created by Roberto Veiga Junior on 28/07/16.
//  Copyright © 2016 RJR. All rights reserved.
//

import UIKit
import TwitterKit

class AccessViewController: UIViewController {
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        User.isLogged {
            self.performSegueWithIdentifier("sgLogged", sender: nil)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let logInButton = TWTRLogInButton(logInCompletion: { session, error in
            if (session != nil) {
                print("signed in as \(session!.userName)")
                self.performSegueWithIdentifier("sgLogged", sender: nil)
            } else {
                print("error: \(error!.localizedDescription)")
            }
        })
        logInButton.center = self.view.center
        self.view.addSubview(logInButton)
    }
}
