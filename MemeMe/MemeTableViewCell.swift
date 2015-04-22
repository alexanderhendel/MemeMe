//
//  MemeTableViewCell.swift
//  MemeMe
//
//  Created by Hiro on 20/04/15.
//  Copyright (c) 2015 alexhendel. All rights reserved.
//

import UIKit

class MemeTableViewCell: UITableViewCell {

    @IBOutlet weak var memeImage: UIImageView!
    @IBOutlet weak var memeTopText: UILabel!
    @IBOutlet weak var memeBottomText: UILabel!
    
    func setCell(memeObject: meme) {
    
        self.memeImage.image = memeObject.memeImage
        self.memeTopText.text = memeObject.topText
        self.memeBottomText.text = memeObject.bottomText
    }

}
