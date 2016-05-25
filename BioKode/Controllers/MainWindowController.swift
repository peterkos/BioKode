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
        (self.contentViewController! as! NSTabViewController).selectedTabViewItemIndex = sender.selectedSegment
	}
	
	override func windowDidLoad() {
		self.window!.titleVisibility = .Hidden
	}
}
