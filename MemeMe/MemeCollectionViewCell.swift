//
//  MemeCollectionViewCell.swift
//  MemeMe
//
//  Created by Hiro on 21/04/15.
//  Copyright (c) 2015 alexhendel. All rights reserved.
//

import UIKit

class MemeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cellImage: UIImageView!
    
    func setCell(myMeme: meme) {
    
        self.cellImage.image = myMeme.memeImage
    }
}
