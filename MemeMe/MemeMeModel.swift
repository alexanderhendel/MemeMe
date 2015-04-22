//
//  MemeMeModel.swift
//  MemeMe
//
//  Created by Hiro on 19/04/15.
//  Copyright (c) 2015 alexhendel. All rights reserved.
//

import Foundation
import UIKit

class meme: NSObject {

    var topText: String?
    var bottomText: String?
    var image: UIImage?
    var memeImage: UIImage?
    
    override init() {
        
        self.topText = ""
        self.bottomText = ""
         
    }
}
