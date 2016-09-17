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
	@IBOutlet weak var outputSpacingSelectionAsAllOneWord: NSButton!
	@IBOutlet weak var outputSpacingSelectionAsGroupsOfThree: NSButton!
	
	
	// Set default input selection
    @IBAction func defaultInputSelectionSelected(_ sender: AnyObject) {
        UserDefaults.standard.set(defaultInputSelection.selectedSegment, forKey: "defaultInputSelection")
    }
	
	// Set default output selection
	@IBAction func defaultOutputSelectionSelected(_ sender: AnyObject) {
		UserDefaults.standard.set(defaultOutputSelection.selectedSegment, forKey: "defaultOutputSelection")
	}
	
	// Set default polygenetic selection
    @IBAction func polygeneticSelectionSelected(_ sender: AnyObject) {
        if (polygeneticSelectionFirst.state == 1) {
            UserDefaults.standard.set(1, forKey: "polygeneticSelection")
        } else {
			// Possible bug: polygeneticSelection key is set to 0.
            UserDefaults.standard.set(2, forKey: "polygeneticSelection")
        }
    }
	
	// Sets default output spacing
	@IBAction func outputSpacingSelectionSelected(_ sender: AnyObject) {
		if (outputSpacingSelectionAsAllOneWord.state == 1) {
			UserDefaults.standard.set(1, forKey: "outputSpacingSelection")
		} else {
			// Possible bug: polygeneticSelection key is set to 0.
			UserDefaults.standard.set(2, forKey: "outputSpacingSelection")
		}
	}
	
	
	// When the view loads, load the last set preference
    override func viewDidLoad() {
        super.viewDidLoad()
        
        defaultInputSelection.selectedSegment = UserDefaults.standard.value(forKey: "defaultInputSelection") as! Int
        defaultOutputSelection.selectedSegment = UserDefaults.standard.value(forKey: "defaultOutputSelection") as! Int
		
        if (UserDefaults.standard.value(forKey: "polygeneticSelection") as! Int == 1) {
            polygeneticSelectionFirst.state = 1
        } else if (UserDefaults.standard.value(forKey: "polygeneticSelection") as! Int == 2) {
            polygeneticSelectionRandom.state = 2
		}
		
		if (UserDefaults.standard.value(forKey: "outputSpacingSelection") as! Int == 1) {
			outputSpacingSelectionAsAllOneWord.state = 1
		} else {
			outputSpacingSelectionAsGroupsOfThree.state = 2;
		}
		
        
    }
	
    override func viewDidDisappear() {
		NotificationCenter.default.post(name: Notification.Name(rawValue: "preferencesDidUpdate"), object: nil)
    }

}
