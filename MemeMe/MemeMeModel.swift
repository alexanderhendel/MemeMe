//
//  MemeMeModel.swift
//  MemeMe
//
//  Created by Hiro on 19/04/15.
//  Copyright (c) 2015 alexhendel. All rights reserved.
//

import Foundation
import UIKit

class meme: NSObject, NSCoding {

    var topText: String?
    var bottomText: String?
    var image: UIImage?
    var memeImage: UIImage?
    
    override init() {
        
        super.init()
    }
    
    // init with NSCoder object - save memes between launches
    required init(coder decoder: NSCoder) {
    
        // init
        super.init()
        
        // decode stuff
        self.topText = decoder.decodeObjectForKey("topText") as! String?
        self.bottomText = decoder.decodeObjectForKey("bottomText") as! String?
        self.image = decoder.decodeObjectForKey("image") as! UIImage?
        self.memeImage = decoder.decodeObjectForKey("memeImage") as! UIImage?
    }
    
    func encodeWithCoder(coder: NSCoder) {

        // encode stuff
        coder.encodeObject(self.topText, forKey: "topText")
        coder.encodeObject(self.bottomText, forKey: "bottomText")
        coder.encodeObject(self.image, forKey: "image")
        coder.encodeObject(self.memeImage, forKey: "memeImage")
    }
}
