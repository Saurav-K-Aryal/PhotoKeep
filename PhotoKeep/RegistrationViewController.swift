//
//  RegistrationViewController.swift
//  PhotoKeep
//
//  Created by Saurav Aryal on 3/22/16.
//  Copyright © 2016 Saurav Aryal. All rights reserved.
//

import Foundation

import UIKit


class RegistrationViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var RegistrationEmail: UITextField!
    
    
    @IBOutlet weak var RegistrationPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func pressRegister(sender: AnyObject) {
        KCSUser.userWithUsername(
            RegistrationEmail.text,
            password: RegistrationPassword.text,
            fieldsAndValues: nil,
            withCompletionBlock: { (user: KCSUser!, errorOrNil: NSError!, result: KCSUserActionResult) -> Void in
                if errorOrNil == nil {
                    print("User created!")
                    self.performSegueWithIdentifier("RegistrationToHome", sender: self)
                } else {
                    let message = errorOrNil.localizedDescription
                    let alert = UIAlertView(
                        title: NSLocalizedString("Log-in failed", comment: "Sign account failed"),
                        message: message,
                        delegate: nil,
                        cancelButtonTitle: NSLocalizedString("OK", comment: "OK")
                    )
                    alert.show()
                    
                }
            }
        )
        
    }
    
}