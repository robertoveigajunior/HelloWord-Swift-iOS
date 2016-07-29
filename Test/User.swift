//
//  User.swift
//  Test
//
//  Created by Roberto Luiz Veiga Junior on 28/07/16.
//  Copyright © 2016 RJR. All rights reserved.
//

import UIKit
import TwitterKit

class User: TWTRAPIClient {
    
    var avatar: UIImage!
    
    class func isLogged(onCompleted:() -> ()) {
        if let session = Twitter.sharedInstance().sessionStore.session() {
            let client = TWTRAPIClient()
            client.loadUserWithID(session.userID) { (user, error) -> Void in
                if let _ = user {
                    onCompleted()
                }
            }
        }
    }
}
