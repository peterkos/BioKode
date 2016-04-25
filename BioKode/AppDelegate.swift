///
//  AppDelegate.swift
//  BioKode
//
//  Created by Peter Kos on 4/19/16.
//  Copyright © 2016 Peter Kos. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
	
	override init() {
		// Sets default default preferences (not a typo)
		let defaults: [String: AnyObject] = ["defaultInputSelection": "0",
		                                     "defaultOutputSelection": "0",
		                                     "polygeneticSelection": "1",
		                                     "outputSpacingSelection": "1"]
		// Initializes default values
		NSUserDefaults.standardUserDefaults().registerDefaults(defaults)
		NSUserDefaults.standardUserDefaults().setInteger(0, forKey: "defaultInputSelection")
		NSUserDefaults.standardUserDefaults().setInteger(0, forKey: "defaultOutputSelection")
		NSUserDefaults.standardUserDefaults().setInteger(1, forKey: "polygeneticSelection")
		NSUserDefaults.standardUserDefaults().setInteger(1, forKey: "outputSpacingSelection")
		
	}
	
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        
    }    
    
    func applicationWillTerminate(aNotification: NSNotification) {
        
    }

}
