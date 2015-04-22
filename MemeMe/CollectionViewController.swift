//
//  CollectionViewController.swift
//  MemeMe
//
//  Created by Hiro on 20/04/15.
//  Copyright (c) 2015 alexhendel. All rights reserved.
//

import UIKit

class CollectionViewController: UICollectionViewController {
    
    @IBOutlet weak var editButton: UIBarButtonItem!
    // MARK: - var
    var memes: [meme]!
    
    // MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        // super
        super.viewWillAppear(true)
        
        // shared model
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        memes = appDelegate.memes
        
        collectionView?.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.memes.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell: MemeCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("memeCollectionCell", forIndexPath: indexPath) as! MemeCollectionViewCell
        
        let m = self.memes[indexPath.row]
        
        cell.setCell(m)
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {

        //Grab the DetailMemeViewController from Storyboard
        let object:AnyObject = self.storyboard!.instantiateViewControllerWithIdentifier("DetailMemeViewController")!
        
        let dmvc = object as! DetailMemeViewController
        
        //Populate view controller with data from the selected item
        dmvc.currentMeme = self.memes[indexPath.row]
        
        //Present the view controller using navigation
        self.navigationController!.pushViewController(dmvc, animated: true)
    }
    
}
