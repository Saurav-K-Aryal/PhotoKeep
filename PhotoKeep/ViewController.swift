//
//  ViewController.swift
//  PhotoKeep
//
//  Created by Saurav Aryal on 3/22/16.
//  Copyright © 2016 Saurav Aryal. All rights reserved.
//

import UIKit

class SomeImage: NSObject {
    var someName: String?
    var somePlace: String?
    var someId: String?
    var someImage: UIImage?
    
    override func hostToKinveyPropertyMapping() -> [NSObject : AnyObject]! {
        return [
            "someId" : KCSEntityKeyId,
            "someName" : "someName",
            "somePlace" : "somePlace",
            "someImage" : "someImage",
        ]
    }
    override class func kinveyPropertyToCollectionMapping() -> [NSObject : AnyObject]! {
        return [
            "someImage" : KCSFileStoreCollectionName,
        ]
    }
    
    override func referenceKinveyPropertiesOfObjectsToSave() -> [AnyObject]! {
        return ["someImage"]
    }
}



class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
     var datePicker = UIDatePicker()

    @IBOutlet weak var DateField: UITextField!
    
    @IBOutlet weak var pickDate: UIButton!
    
    @IBOutlet weak var WelcomeLabel: UILabel!
    
    
    @IBOutlet weak var GalleryImageButton: UIButton!
    
    @IBOutlet weak var LogoutButton: UIButton!
    
    @IBOutlet weak var CameraButton: UIButton!
    
    @IBOutlet weak var uploadButton: UIButton!
    
    @IBOutlet weak var imageView: UIImageView!
    
    let imagePicker = UIImagePickerController()
    
    func initializeDatePicker() {
        
        datePicker.datePickerMode = UIDatePickerMode.Date;
        
        // this will make the picker appear, when the date
        // needs to be set
        DateField.inputView = datePicker
        DateField.textAlignment = .Center
        
        // set the tool bar
        let toolBar = UIToolbar(frame: CGRect.init(x:0, y:0, width:320, height:44))
        toolBar.tintColor = UIColor.grayColor()
        
        let doneBtn = UIBarButtonItem(title: "Done", style: .Plain, target: self, action: "datePickerChanged")
        
        let canelBtn = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: "datePickerCancelled")
        
        let spacerBtn = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([canelBtn,spacerBtn,doneBtn], animated: true)
        DateField.inputAccessoryView = toolBar
        
    }

    
    
    @IBAction func pickDateClicked(sender: AnyObject) {
        DateField.becomeFirstResponder()
    }
    
    // when user cancels, just resign first responder and keep it moving
    func datePickerCancelled() {
        DateField.resignFirstResponder()
    }
    

    func datePickerChanged() {
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.dateStyle = NSDateFormatterStyle.LongStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        
        let strDate = dateFormatter.stringFromDate(datePicker.date)
        DateField.text = strDate
        DateField.resignFirstResponder()
    }
    
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
    
    
    @IBAction func uploadImage(sender: AnyObject)
    {
        let someImageStore = KCSLinkedAppdataStore.storeWithOptions([
            KCSStoreKeyCollectionName: "Some-Image-collection",
            KCSStoreKeyCollectionTemplateClass : SomeImage.self
            ])
        
        let someImage = SomeImage()
        someImage.someName = "Object with Image"
        someImage.somePlace = "New York, NY, Haribol"
        someImage.someImage = imageView.image
        
        someImageStore.saveObject(someImage, withCompletionBlock: {
            (objectsOrNil:[AnyObject]!, errorOrNil: NSError!) -> Void in
            print("Image Object Saved")
            
            }, withProgressBlock: nil)
        
    }

    
    
    @IBAction func chooseLocalImage(sender: AnyObject) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func takePhoto(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(
            UIImagePickerControllerSourceType.Camera) {
            imagePicker.sourceType =
                .Camera
            imagePicker.allowsEditing = false
        self.presentViewController(imagePicker, animated: true,                                       completion: nil)
        }
        else {
            print("camera not found..")
        }
        
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
        imagePicker.delegate = self
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
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.contentMode = .ScaleAspectFit
            imageView.image = pickedImage
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }


}

