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
		let defaults: [String: AnyObject] = ["defaultInputSelection": "0" as AnyObject,
		                                     "defaultOutputSelection": "0" as AnyObject,
		                                     "polygeneticSelection": "1" as AnyObject,
		                                     "outputSpacingSelection": "1" as AnyObject]
		// Initializes default values
		UserDefaults.standard.register(defaults: defaults)
		UserDefaults.standard.set(0, forKey: "defaultInputSelection")
		UserDefaults.standard.set(0, forKey: "defaultOutputSelection")
		UserDefaults.standard.set(1, forKey: "polygeneticSelection")
		UserDefaults.standard.set(1, forKey: "outputSpacingSelection")
		
	}
	
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
    }    
    
    func applicationWillTerminate(_ aNotification: Notification) {
        
    }

}
