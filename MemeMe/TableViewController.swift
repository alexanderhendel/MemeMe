//
//  TableViewController.swift
//  MemeMe
//
//  Created by Hiro on 20/04/15.
//  Copyright (c) 2015 alexhendel. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController,
                           UITableViewDataSource,
                           UITableViewDelegate {
    
    @IBOutlet weak var editButton: UIBarButtonItem!
    var memes: [meme]!
    
    // MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        memes = appDelegate.memes
        
        // force table view to reload data when it becomes visible
        tableView.reloadData()
        
        // if the memes array holds no data then show editor
        if self.memes.count == 0 {
            
            performSegueWithIdentifier("EditMemeSegue", sender: self)
        }
    }
    
    // MARK: - TableView Protocol
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.memes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: MemeTableViewCell = tableView.dequeueReusableCellWithIdentifier("MemeCell") as! MemeTableViewCell
        
        let m = self.memes[indexPath.row]
        
        cell.setCell(m)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        // grab the DetailMemeViewController from Storyboard
        let object:AnyObject = self.storyboard!.instantiateViewControllerWithIdentifier("DetailMemeViewController")!
        
        let dmvc = object as! DetailMemeViewController
        
        // pass current meme to detail view
        dmvc.currentMeme = self.memes[indexPath.row]
        
        // show detail view
        self.navigationController!.pushViewController(dmvc, animated: true)
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
        
            let object = UIApplication.sharedApplication().delegate
            let appDelegate = object as! AppDelegate
            
            // remove item from data source
            appDelegate.memes.removeAtIndex(indexPath.row)
            self.memes = appDelegate.memes
            
            // update table
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
            
            // reload
            tableView.reloadData()
            
            // end editing
            tableView.setEditing(false, animated: true)
            editButton.enabled = true
        }
    }
    
    // MARK: - IBActions
    @IBAction func editModeForTableView(sender: UIBarButtonItem) {
        
        // only enter editing if there is something to edit in the table
        if self.memes.count > 0 {

            // set edit mode and disabl edit button
            tableView.setEditing(true, animated: true)
            editButton.enabled = false
        }
    }
}