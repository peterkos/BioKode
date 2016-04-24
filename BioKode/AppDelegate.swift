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
        
        // Sets default default preferences
        let defaults: [String: AnyObject] = ["defaultInputSelection": "0",
                                            "defaultOutputSelection": "0",
                                            "polygeneticSelection": "0"]
        NSUserDefaults.standardUserDefaults().registerDefaults(defaults)
    }
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Sets default preferences
        NSUserDefaults.standardUserDefaults().setInteger(0, forKey: "defaultInputSelection")
        NSUserDefaults.standardUserDefaults().setInteger(0, forKey: "defaultOutputSelection")
        NSUserDefaults.standardUserDefaults().setInteger(0, forKey: "polygeneticSelection")
        
        
        
    }    
    
    func applicationWillTerminate(aNotification: NSNotification) {
        
        
    }

}
