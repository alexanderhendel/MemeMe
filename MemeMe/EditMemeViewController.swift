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

    // MARK: - IBOutlet
    @IBOutlet weak var memeImageView: UIImageView!
    @IBOutlet weak var memeTopLabel: UITextField!
    @IBOutlet weak var memeBottomLabel: UITextField!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var toolbar: UIToolbar!
    
    // MARK: - Delegates
    let MemeTextFieldDelegate = memeTextFieldDelegate()
    
    // MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup delegates
        memeTopLabel.delegate = MemeTextFieldDelegate
        memeBottomLabel.delegate = MemeTextFieldDelegate
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
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
        
        // disable share Buttom only when imageView is empty
        if self.memeImageView.image == nil {
            shareButton.enabled = false
        }
    }

    override func viewWillDisappear(animated: Bool) {
        
        super.viewWillDisappear(animated)
        self.unsubscribeFromKeyboardNotifications()
    }
    
    // MARK: - Keyboard Notifications
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

    // MARK: - Custom Functions
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        NSLog("\(keyboardSize)")
        
        return keyboardSize.CGRectValue().height
    }
    
    func save() {
    
        // setup meme object
        var myMeme = meme()
        
        myMeme.topText = memeTopLabel.text
        myMeme.bottomText = memeBottomLabel.text
        myMeme.image = memeImageView.image
            
        myMeme.memeImage = self.generateMemedImage()
    }

    @IBAction func shareMeme(sender: UIBarButtonItem) {
        
        // share your fancy meme :)
        let activityItem = generateMemedImage()
        let activityViewController = UIActivityViewController(activityItems: [activityItem],
            applicationActivities: nil)
        
        self.presentViewController(activityViewController, animated: true, completion: nil)
    }
    
    func generateMemedImage() -> UIImage {
        
        // Hide toolbar and navbar
        self.navigationController?.navigationBar.hidden = true
        self.toolbar.hidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        
        self.view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        
        let memedImage : UIImage =
            UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        
        // Show toolbar and navbar
        self.navigationController?.navigationBar.hidden = false
        self.toolbar.hidden = false
        
        return memedImage
    }
    
    func showImagePickerOfType(pickerType: UIImagePickerControllerSourceType) {
        
        // show image picker with different sources (Camera or Photo Library)
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = pickerType
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    // MARK: - Image Picker Protocol
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            memeImageView.image = image
            shareButton.enabled = true
            
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    // MARK: - IBActions
    @IBAction func pickImageFromCamera(sender: UIBarButtonItem) {
        
        self.showImagePickerOfType(UIImagePickerControllerSourceType.Camera)
    }

    @IBAction func pickImageFromAlbum(sender: UIBarButtonItem) {
        
        self.showImagePickerOfType(UIImagePickerControllerSourceType.PhotoLibrary)
    }
    
    @IBAction func cancelMemeEdit(sender: UIBarButtonItem) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

