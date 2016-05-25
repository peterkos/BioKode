//
//  MainWindowController.swift
//  BioKode
//
//  Created by Peter Kos on 5/24/16.
//  Copyright © 2016 Peter Kos. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {
	
	@IBOutlet weak var toolbarNavigation: NSToolbar!
	
	// Dealing with toolbar input
	@IBAction func toolbarItemIsSelected(sender: NSSegmentedControl) {
		if sender.selectedSegment == 0 {
			print("0 selected")
            self.contentViewController!.performSegueWithIdentifier("switchToShortView", sender: self)
		} else {
			print("1 selected")
            self.contentViewController!.performSegueWithIdentifier("switchToLongView", sender: self)
		}
	}
	

	
	override func windowDidLoad() {
		self.window!.titleVisibility = .Hidden
	}
}
