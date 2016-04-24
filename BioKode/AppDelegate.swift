//
//  AppDelegate.swift
//  BioKode
//
//  Created by Peter Kos on 4/19/16.
//  Copyright © 2016 Peter Kos. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    func applicationWillFinishLaunching(notification: NSNotification) {
        
        var defaults: [String: AnyObject] = ["0": "defaultInputSelection"]
        NSUserDefaults.standardUserDefaults().registerDefaults(defaults)
    }
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Sets default preferences
        NSUserDefaults.standardUserDefaults().setInteger(0, forKey: "defaultInputSelection")
//        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "polygeneticSelectionFirst")
//        NSUserDefaults.standardUserDefaults().setBool(false, forKey: "polygeneticSelectionFirst")
        
        
    }    
    
    func applicationWillTerminate(aNotification: NSNotification) {
        
        
    }

}
