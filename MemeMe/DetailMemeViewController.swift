//
//  DetailMemeViewController.swift
//  MemeMe
//
//  Created by Hiro on 21/04/15.
//  Copyright (c) 2015 alexhendel. All rights reserved.
//

import UIKit

class DetailMemeViewController: UIViewController {
    
    @IBOutlet weak var ImageView: UIImageView!
    var currentMeme: meme!
    
    // MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        if self.currentMeme != nil {
        
            self.ImageView.image = currentMeme.memeImage
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }

    // MARK: - IBAction
    @IBAction func deleteMeme(sender: UIBarButtonItem) {
        
        // TODO: implement delete meme from detail view
    }
    
    @IBAction func editMeme(sender: UIBarButtonItem) {
        
        // TODO: implement edit meme from detail view
    }
}
