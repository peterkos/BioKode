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
    @IBAction func defaultInputSelectionSelected(sender: AnyObject) {
        NSUserDefaults.standardUserDefaults().setObject(defaultInputSelection.selectedSegment, forKey: "defaultInputSelection")
    }
    
    @IBAction func polygeneticSelectionSelected(sender: AnyObject) {
        if (polygeneticSelectionFirst.state == 1) {
            NSUserDefaults.standardUserDefaults().setInteger(0, forKey: "polygeneticSelection")
        } else {
            NSUserDefaults.standardUserDefaults().setInteger(1, forKey: "polygeneticSelection")
        }
    }
    
    
    @IBAction func defaultOutputSelectionSelected(sender: AnyObject) {
        NSUserDefaults.standardUserDefaults().setObject(defaultOutputSelection.selectedSegment, forKey: "defaultOutputSelection")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        defaultInputSelection.selectedSegment = NSUserDefaults.standardUserDefaults().valueForKey("defaultInputSelection") as! Int
        defaultOutputSelection.selectedSegment = NSUserDefaults.standardUserDefaults().valueForKey("defaultOutputSelection") as! Int
        if (NSUserDefaults.standardUserDefaults().valueForKey("polygeneticSelection") as! Int == 0) {
            polygeneticSelectionFirst.state = 1;
        } else {
            polygeneticSelectionRandom.state = 2;
        }
        
        
    }
    
    override func viewWillDisappear() {
        
    }

}
