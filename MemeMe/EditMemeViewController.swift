//
//  EditMemeViewController.swift
//  MemeMe
//
//  Created by Hiro on 19/04/15.
//  Copyright (c) 2015 alexhendel. All rights reserved.
//

import UIKit

class EditMemeViewController: UIViewController,
                              UIImagePickerControllerDelegate,
                              UINavigationControllerDelegate
{

    // IBOutlet
    @IBOutlet weak var memeImage: UIImageView!
    @IBOutlet weak var memeTopLabel: UITextField!
    @IBOutlet weak var memeBottomLabel: UITextField!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    // Delegates
    let MemeTextFieldDelegate = memeTextFieldDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup delegates
        memeTopLabel.delegate = MemeTextFieldDelegate
        memeBottomLabel.delegate = MemeTextFieldDelegate
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        self.subscribeToKeyboardNotifications()
        
        // camera button state depending on the camera availability on the device
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        
        let memeTextAttributes = [
            NSStrokeColorAttributeName : UIColor.blackColor(),
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName : -5.0        ]
        
        memeTopLabel.defaultTextAttributes = memeTextAttributes
        memeBottomLabel.defaultTextAttributes = memeTextAttributes
        
        // setup text fields
        memeTopLabel.textAlignment = NSTextAlignment.Center
        memeTopLabel.autocapitalizationType = UITextAutocapitalizationType.AllCharacters
        
        memeBottomLabel.textAlignment = NSTextAlignment.Center
        memeBottomLabel.autocapitalizationType = UITextAutocapitalizationType.AllCharacters
    }

    override func viewWillDisappear(animated: Bool) {
        
        super.viewWillDisappear(animated)
        self.unsubscribeFromKeyboardNotifications()
    }
    
    func keyboardWillShow(notification: NSNotification) {
        
        //TODO: move keyboard
        //self.view.frame.origin.y -= getKeyboardHeight(notification)
    }
    
    func keyboardWillHide(notification: NSNotification) {
        
        //TODO: move keyboard
        //self.view.frame.origin.y += getKeyboardHeight(notification)
    }

    func subscribeToKeyboardNotifications() {
        
        // keyboard will show subscription
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "keyboardWillShow:",
            name: UIKeyboardWillShowNotification,
            object: nil)
        
        // keyboard will hide subscription
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "keyboardWillHide:",
            name: UIKeyboardWillHideNotification,
            object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        
        // unsubscribe keyboard will show
        NSNotificationCenter.defaultCenter().removeObserver(self,
            name: UIKeyboardWillShowNotification, object: nil)
        
        // unsubscribe keyboard will hide
        NSNotificationCenter.defaultCenter().removeObserver(self,
            name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        NSLog("\(keyboardSize)")
        
        return keyboardSize.CGRectValue().height
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelMemeEdit(sender: UIBarButtonItem) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    // show image picker with different sources (Camera or Photo Library)
    func showImagePickerOfType(pickerType: UIImagePickerControllerSourceType) {

        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = pickerType
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func pickImageFromCamera(sender: UIBarButtonItem) {
        
        self.showImagePickerOfType(UIImagePickerControllerSourceType.Camera)
    }

    @IBAction func pickImageFromAlbum(sender: UIBarButtonItem) {
        
        self.showImagePickerOfType(UIImagePickerControllerSourceType.PhotoLibrary)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            memeImage.image = image
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
}

