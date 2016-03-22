//
//  ViewController.swift
//  PhotoKeep
//
//  Created by Saurav Aryal on 3/22/16.
//  Copyright © 2016 Saurav Aryal. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

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
        if KCSUser.activeUser() == nil {
            self.performSegueWithIdentifier("LoginView", sender: self)
            
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

