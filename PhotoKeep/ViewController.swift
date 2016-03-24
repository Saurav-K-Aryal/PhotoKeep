//
//  ViewController.swift
//  PhotoKeep
//
//  Created by Saurav Aryal on 3/22/16.
//  Copyright © 2016 Saurav Aryal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var WelcomeLabel: UILabel!
    
    
    @IBOutlet weak var GalleryImageButton: UIButton!
    
    @IBOutlet weak var LogoutButton: UIButton!
    
    @IBOutlet weak var CameraButton: UIButton!
    
    @IBAction func pressedLogout(sender: AnyObject) {
        KCSUser.activeUser().logout()
        let message:String = "Logout Succesful"
        let alert = UIAlertView(
            title: NSLocalizedString("Logging out..", comment: "Logging out.."),
            message: message,
            delegate: nil,
            cancelButtonTitle: NSLocalizedString("OK", comment: "OK")
        )
        alert.show()
    
    self.performSegueWithIdentifier("LoginView", sender: self)
    }
    
    @IBAction func takePhoto(sender: AnyObject) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        KCSClient.sharedClient().initializeKinveyServiceForAppKey(
            "kid_-1sfNL67yW",
            withAppSecret: "c23f70ec6f4c482491c222ef8cc5ca9f",
            usingOptions: nil
        )
        
//        KCSPing.pingKinveyWithBlock { (result: KCSPingResult!) -> Void in
//            if result.pingWasSuccessful {
//                print("Kinvey Ping Success")
//            } else {
//                print("Kinvey Ping Failed")
//            }
//        }
        let user_data = KCSUser.activeUser()
        if user_data == nil {
            self.performSegueWithIdentifier("LoginView", sender: self)
        }
        else {
        let user_name = user_data.username
        
        }
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

