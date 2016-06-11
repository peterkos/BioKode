//
//  ShortViewController.swift
//  BioKode
//
//  Created by Peter Kos on 5/31/16.
//  Copyright © 2016 Peter Kos. All rights reserved.
//

import Cocoa

class ShortViewController: NSViewController {
    
    // General purpose objects
    let errorCheck = ErrorCheck()
    var alert = NSAlert()
    let bioTrans = BioTranslate()
    
    // IB Ivars
    @IBOutlet weak var shortInputSelection: NSSegmentedControl!
    @IBOutlet weak var shortInput: NSTextField!
    
    @IBOutlet weak var shortOutputSelection: NSSegmentedControl!
    @IBOutlet weak var shortOutput: NSTextField!
    
    @IBOutlet weak var shortReset: NSButton!
    
    @IBAction func shortResetSelected(sender: NSButton) {
        shortInputSelection.setSelected(false, forSegment: shortInputSelection.selectedSegment)
        shortOutputSelection.setSelected(false, forSegment: shortOutputSelection.selectedSegment)
        shortInput.stringValue = ""
        shortOutput.stringValue = ""
    }
    
    @IBAction func inputIsSelected(sender: NSSegmentedControl) {
        
        // Replaces placeholder text
        if (shortInputSelection.selectedSegment == 0) {
            shortInput.placeholderString = "ACTGCGGTCGAC"
        } else if (shortInputSelection.selectedSegment == 1) {
            shortInput.placeholderString = "ACUGCGGUCGAC"
        } else {
            shortInput.placeholderString = "Cookie"
        }
        
        shortOutputSelection.setSelected(false, forSegment: shortOutputSelection.selectedSegment)
        
    }
    
    @IBAction func outputIsSelected(sender: NSSegmentedControl) {
        
        guard !errorCheck.stringIsNotEmpty(shortInput.stringValue) else {
            invalidEmptyInput()
            return
        }
        
        // 0 = DNA, 1 = mRNA, 2 = English
        if (shortInputSelection.selectedSegment == 0) {
            checkPossibleConversionAndConvertDNA()
        } else if (shortInputSelection.selectedSegment == 1) {
            checkPossibleConversionAndConvertmRNA()
        } else if (shortInputSelection.selectedSegment == 2) {
            checkPossibleConversionAndConvertEnglish()
        }
    }
    
    // ----------------------------------------------
    // Custom Functions
    // ----------------------------------------------
    
    
    // Error checking & calculation functions for input
    func checkPossibleConversionAndConvertDNA() {
        
        guard !errorCheck.isValidDNA(shortInput.stringValue) else {
            invalidDNASequence()
            return
        }
        
        switch shortOutputSelection.selectedSegment {
        case 0: shortOutput.stringValue = shortInput.stringValue.uppercaseString;
        case 1: shortOutput.stringValue = bioTrans.fromDNAtomRNA(shortInput.stringValue)
        case 2: shortOutput.stringValue = bioTrans.fromDNAtoEnglish(shortInput.stringValue)
        default: return
        }
    }
    
    func checkPossibleConversionAndConvertmRNA() {
        
        guard !errorCheck.isValidmRNA(shortInput.stringValue) else {
            invalidmRNASequence()
            return
        }
        
        switch shortOutputSelection.selectedSegment {
        case 0: shortOutput.stringValue = bioTrans.frommRNAtoDNA(shortInput.stringValue)
        case 1: shortOutput.stringValue = shortInput.stringValue.uppercaseString
        case 2: bioTrans.frommRNAtoEnglish(shortInput.stringValue)
        default: return
        }
    }
    
    func checkPossibleConversionAndConvertEnglish() {
        
        // No guard -- English has no default constraints
        switch shortOutputSelection.selectedSegment {
        case 0: shortOutput.stringValue = bioTrans.fromEnglishtoDNA(shortInput.stringValue)
        case 1: shortOutput.stringValue = bioTrans.fromEnglishtomRNA(shortInput.stringValue)
        case 2: shortOutput.stringValue = shortInput.stringValue.uppercaseString
        default: return
        }
    }
    
    
    // ----------------------------------------------
    // Error delegate functions
    // ----------------------------------------------
    func alertButtonsAndActions() {
        alert.addButtonWithTitle("OK")
        alert.addButtonWithTitle("Clear Input")
        alert.addButtonWithTitle("Clear Input & Output")
        let alertResponse = alert.runModal()
        
        // SecondButton = clear in, ThirdButton = clear in & out
        // Output segments are cleared either way to allow user to re-apply conversion.
        if (alertResponse == NSAlertSecondButtonReturn) {
            shortInput.stringValue = ""
            shortOutputSelection.setSelected(false, forSegment: shortOutputSelection.selectedSegment)
        } else if (alertResponse == NSAlertThirdButtonReturn) {
            shortInput.stringValue = ""
            shortOutput.stringValue = ""
            shortOutputSelection.setSelected(false, forSegment: shortOutputSelection.selectedSegment)
        }
        
        // Resets alert so buttons aren't duplicated
        alert = NSAlert()
    }
    
    func invalidDNASequence() {
        alert.messageText = "Uh oh!"
        alert.informativeText = "Invalid sequence. Must contain A, C, T, or G, and the total length must be a multiple of 3."
        alertButtonsAndActions()
    }
    
    func invalidmRNASequence() {
        alert.messageText = "Uh oh!"
        alert.informativeText = "Invalid sequence. Must contain A, C, U, or G, and the total length must be a multiple of 3."
        alertButtonsAndActions()
    }
    
    func invalidEmptyInput() {
        alert.messageText = "Convert whitespace? That's a new one."
        alert.informativeText = "Input string cannot be empty."
        alertButtonsAndActions()
    }
    
    
    // ----------------------------------------------
    // Not-so Custom Functions
    // ----------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Notification when preference is changed
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(preferencesDidUpdate), name: "preferencesDidUpdate", object: nil)
        
    }
    
    // Updates buttons to reflect change in NSUserDefaults without restart
    func preferencesDidUpdate() {
        shortInputSelection.selectedSegment = NSUserDefaults.standardUserDefaults().valueForKey("defaultInputSelection") as! Int
        shortOutputSelection.selectedSegment = NSUserDefaults.standardUserDefaults().valueForKey("defaultOutputSelection") as! Int
    }
    
    
    override var representedObject: AnyObject? {
        didSet {
            // Update the view, if already loaded.
        }
    }

    
}
