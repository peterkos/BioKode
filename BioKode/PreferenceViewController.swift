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
        print(NSUserDefaults.standardUserDefaults().integerForKey("defaultInputSelection"))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
    }
    
    override func viewWillDisappear() {
        
    }

}
