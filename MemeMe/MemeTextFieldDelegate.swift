//
//  MemeTextFieldDelegate.swift
//  MemeMe
//
//  Created by Hiro on 19/04/15.
//  Copyright (c) 2015 alexhendel. All rights reserved.
//

import Foundation
import UIKit

class memeTextFieldDelegate: NSObject, UITextFieldDelegate {

    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        
        // empty text field when user wants to enter something
        textField.endEditing(true)
        
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        // dismiss keyboard when user presses return
        
        return true
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        // capitalize everything
        textField.text = textField.text.uppercaseString
        
        return true
    }
}
