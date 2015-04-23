//
//  AppDelegate.swift
//  MemeMe
//
//  Created by Hiro on 19/04/15.
//  Copyright (c) 2015 alexhendel. All rights reserved.
//

import Foundation
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var memeStorageFile: String!
    var memes = [meme]()        // shared model

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // get storage file
        let documentsDir: String!
        
        documentsDir = self.applicationDocumentsDirectory()
        memeStorageFile = documentsDir.stringByAppendingPathComponent("Storage")
        
        // load from storage
        self.loadMemes()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        self.saveMemes()
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        
        self.saveMemes()
    }

    // MARK: custom functions
    func saveMemes() -> Bool {
    
        // save data
        // unwrap memeStorageFile
        if memeStorageFile != nil {
            
            return NSKeyedArchiver.archiveRootObject(memes, toFile: memeStorageFile)
        } else {
            
            return false
        }
    }
    
    func loadMemes() {
    
        // unwrap memeStorageFile
        if memeStorageFile != nil {
            var unarchivedMemes = NSArray()
            
            // unwrap NSKeyedUnarchiver
            if NSKeyedUnarchiver.unarchiveObjectWithFile(memeStorageFile) != nil {
                
                unarchivedMemes = NSKeyedUnarchiver.unarchiveObjectWithFile(memeStorageFile) as! NSArray
            }
            
            // Output the new array
            for m: AnyObject in unarchivedMemes {
                
                self.memes.append(m as! meme)
            }
        } else {
            NSLog("couldnt load memes, storage file was nil")
        }
    }
    
    // Returns the URL to the application's Documents directory.
    func applicationDocumentsDirectory() -> String {
        
        // find user Documents directory
        let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        
        return documentsPath
    }
}

