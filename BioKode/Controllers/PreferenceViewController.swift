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
	@IBOutlet weak var outputSpacingSelectionUnified: NSButton!
	@IBOutlet weak var outputSpacingSelectionGrouped: NSButton!
	
	let prefs = NSUserDefaults.standardUserDefaults()
    
	// Set default input selection
    @IBAction func defaultInputSelectionSelected(sender: NSSegmentedControl) {
        prefs.setInteger(defaultInputSelection.selectedSegment, forKey: "defaultInputSelection")
    }
	
	// Set default output selection
	@IBAction func defaultOutputSelectionSelected(sender: NSSegmentedControl) {
		prefs.setInteger(defaultOutputSelection.selectedSegment, forKey: "defaultOutputSelection")
	}
	
	// Set default polygenetic selection
    @IBAction func polygeneticSelectionSelected(sender: NSSegmentedControl) {
        if (polygeneticSelectionFirst.state == 1) {
            prefs.setInteger(1, forKey: "polygeneticSelection")
        } else {
			// Possible bug: polygeneticSelection key is set to 0.
            prefs.setInteger(2, forKey: "polygeneticSelection")
        }
    }
	
	// Sets default output spacing
	@IBAction func outputSpacingSelectionSelected(sender: AnyObject) {
		if (outputSpacingSelectionUnified.state == 1) {
			prefs.setInteger(1, forKey: "outputSpacingSelection")
		} else {
			// Possible bug: polygeneticSelection key is set to 0.
			prefs.setInteger(2, forKey: "outputSpacingSelection")
		}
	}
	
	
	// When the view loads, load the last set preference
    override func viewDidLoad() {
        super.viewDidLoad()
        
        defaultInputSelection.selectedSegment = prefs.valueForKey("defaultInputSelection") as! Int
        defaultOutputSelection.selectedSegment = prefs.valueForKey("defaultOutputSelection") as! Int
		
        if (prefs.valueForKey("polygeneticSelection") as! Int == 1) {
            polygeneticSelectionFirst.state = 1
        } else if (prefs.valueForKey("polygeneticSelection") as! Int == 2) {
            polygeneticSelectionRandom.state = 2
		}
		
		if (prefs.valueForKey("outputSpacingSelection") as! Int == 1) {
			outputSpacingSelectionUnified.state = 1
		} else {
			outputSpacingSelectionGrouped.state = 2;
		}
		
        
    }
	
    override func viewDidDisappear() {
		NSNotificationCenter.defaultCenter().postNotificationName("preferencesDidUpdate", object: nil)
    }

}
