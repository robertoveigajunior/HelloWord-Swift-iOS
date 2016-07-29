//
//  AvatarViewController.swift
//  Test
//
//  Created by Roberto Veiga Junior on 28/07/16.
//  Copyright © 2016 RJR. All rights reserved.
//

import UIKit
import Crashlytics
import TwitterKit

class AvatarViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var btNext: UIButton!
    @IBOutlet weak var aiLoading: UIActivityIndicatorView!
    @IBOutlet weak var btLogout: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initCommon()
    }
    
    private func setTitles() {
        self.btNext.setTitle("btNext.normalTitle".localized, forState: .Normal)
    }
    
    private func imageRadius() {
        self.imgAvatar.layer.cornerRadius = self.imgAvatar.frame.width/2
        self.imgAvatar.layer.masksToBounds = true
        self.imgAvatar.setBorder
    }
    
    private func initCommon() {
        self.btNext.hidden = true
        self.imageRadius()
        Answers.logContentViewWithName("Tweet", contentType: "Video", contentId: "1234", customAttributes: ["Favorites Count":20, "Screen Orientation":"Landscape"])
    }
    
    private func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera;
            imagePicker.allowsEditing = false
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    
    private func nextPage() {
        self.performSegueWithIdentifier("sgRecorder", sender: self.imgAvatar.image)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let view = segue.destinationViewController as! LocationViewController
        view.avatar = sender as! UIImage
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!) {
        let selectedImage : UIImage = image
        self.imgAvatar.image = selectedImage
        AppDelegate().setAvatar(selectedImage)
        self.dismissViewControllerAnimated(true, completion: nil)
        self.btNext.hidden = false
    }
    
    @IBAction func tapOnAvatar(sender: AnyObject) {
        self.openCamera()
    }
    
    @IBAction func doNext(sender: UIButton) {
        self.nextPage()
    }
    
    @IBAction func doLogout(sender: AnyObject) {
        self.aiLoading.startAnimating()
        self.btLogout.hidden = true
        if let session = Twitter.sharedInstance().sessionStore.session() {
            let client = TWTRAPIClient()
            client.loadUserWithID(session.userID) { (user, error) -> Void in
                if let user = user {
                    self.aiLoading.stopAnimating()
                    self.btLogout.hidden = false
                    Twitter.sharedInstance().sessionStore.logOutUserID(user.userID)
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
            }
        } else {
            self.aiLoading.stopAnimating()
            self.btLogout.hidden = false
        }
    }
}
