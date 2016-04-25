//
//  PreferenceViewController.swift
//  BioKode
//
//  Created by Peter Kos on 4/24/16.
//  Copyright © 2016 Peter Kos. All rights reserved.
//

import Cocoa

class PreferenceViewController: NSViewController {

    @IBOutlet weak var defaultInputSelection: NSSegmentedControl!
    @IBOutlet weak var defaultOutputSelection: NSSegmentedControl!
    @IBOutlet weak var polygeneticSelectionFirst: NSButton!
    @IBOutlet weak var polygeneticSelectionRandom: NSButton!
	
	// Set default input selection
    @IBAction func defaultInputSelectionSelected(sender: AnyObject) {
        NSUserDefaults.standardUserDefaults().setObject(defaultInputSelection.selectedSegment, forKey: "defaultInputSelection")
    }
	
	// Set default output selection
	@IBAction func defaultOutputSelectionSelected(sender: AnyObject) {
		NSUserDefaults.standardUserDefaults().setObject(defaultOutputSelection.selectedSegment, forKey: "defaultOutputSelection")
	}
	
	// Set default polygenetic selection
    @IBAction func polygeneticSelectionSelected(sender: AnyObject) {
        if (polygeneticSelectionFirst.state == 1) {
            NSUserDefaults.standardUserDefaults().setInteger(1, forKey: "polygeneticSelection")
        } else {
			// Possible bug: polygeneticSelection key is set to 0.
            NSUserDefaults.standardUserDefaults().setInteger(2, forKey: "polygeneticSelection")
        }
    }
	
	// When the view loads, load the last set preference
    override func viewDidLoad() {
        super.viewDidLoad()
        
        defaultInputSelection.selectedSegment = NSUserDefaults.standardUserDefaults().valueForKey("defaultInputSelection") as! Int
        defaultOutputSelection.selectedSegment = NSUserDefaults.standardUserDefaults().valueForKey("defaultOutputSelection") as! Int
        if (NSUserDefaults.standardUserDefaults().valueForKey("polygeneticSelection") as! Int == 1) {
            polygeneticSelectionFirst.state = 1;
        } else if (NSUserDefaults.standardUserDefaults().valueForKey("polygeneticSelection") as! Int == 2) {
            polygeneticSelectionRandom.state = 2;
		} else {
			print(NSUserDefaults.standardUserDefaults().valueForKey("polygeneticSelection") as! Int)
		}
			
        
    }
	
    override func viewDidDisappear() {
		NSNotificationCenter.defaultCenter().postNotificationName("defaultInputSelectionUpdate", object: nil)
    }

}
