//
//  ShortViewController.swift
//  BioKode
//
//  Created by Peter Kos on 5/31/16.
//  Copyright © 2016 Peter Kos. All rights reserved.
//

import Cocoa

class LongViewController: NSViewController {
    
    // General purpose objects
    let errorCheck = ErrorCheck()
    var alert = NSAlert()
    let bioTrans = BioTranslate()
    
    // IB Ivars
    @IBOutlet weak var longInputSelection: NSSegmentedControl!
    @IBOutlet weak var longInput: NSTextView!
    
    @IBOutlet weak var longOutputSelection: NSSegmentedControl!
    @IBOutlet weak var longOutput: NSTextView!
    
    @IBOutlet weak var longReset: NSButton!
    
    @IBAction func longResetSelected(sender: NSButton) {
        longInputSelection.setSelected(false, forSegment: longInputSelection.selectedSegment)
        longOutputSelection.setSelected(false, forSegment: longOutputSelection.selectedSegment)
//        longInput.setSelectedRange(NSRange().toRange())
        longOutput.textStorage?.setAttributedString(NSAttributedString(string: ""))
    }
    
    @IBAction func inputIsSelected(sender: NSSegmentedControl) {
        
        // Replaces placeholder text
        if (longInputSelection.selectedSegment == 0) {
//            longInput = "ACTGCGGTCGAC"
        } else if (longInputSelection.selectedSegment == 1) {
//            longInput.placeholderString = "ACUGCGGUCGAC"
        } else {
//            longInput.placeholderString = "Cookie"
        }
        
        longOutputSelection.setSelected(false, forSegment: longOutputSelection.selectedSegment)
        
    }
    
    @IBAction func outputIsSelected(sender: NSSegmentedControl) {
        
        guard !errorCheck.stringIsNotEmpty(String(longInput.textStorage?.characters)) else {
            invalidEmptyInput()
            return
        }
        
        // 0 = DNA, 1 = mRNA, 2 = English
        if (longInputSelection.selectedSegment == 0) {
            checkPossibleConversionAndConvertDNA()
        } else if (longInputSelection.selectedSegment == 1) {
            checkPossibleConversionAndConvertmRNA()
        } else if (longInputSelection.selectedSegment == 2) {
            checkPossibleConversionAndConvertEnglish()
        }
    }
    
    // ----------------------------------------------
    // Custom Functions
    // ----------------------------------------------
    
    // Easy to access (read-only) String value for NSTextView
    var stringValue: String = ""
    
    // Error checking & calculation functions for input
    func checkPossibleConversionAndConvertDNA() {
        
        
        guard !errorCheck.isValidDNA(stringValue) else {
            invalidDNASequence()
            return
        }
        
        switch longOutputSelection.selectedSegment {
        case 0: longInput.changeCaseOfLetter(self);
        case 1: longInput.textStorage?.setAttributedString(NSAttributedString(string: bioTrans.fromDNAtomRNA(stringValue)))
        case 2: longInput.textStorage?.setAttributedString(NSAttributedString(string: bioTrans.fromDNAtoEnglish(stringValue)))
        default: return
        }
    }
    
    func checkPossibleConversionAndConvertmRNA() {
        
        guard !errorCheck.isValidmRNA(stringValue) else {
            invalidmRNASequence()
            return
        }
        
        switch longOutputSelection.selectedSegment {
        case 0: longInput.textStorage?.setAttributedString(NSAttributedString(string: bioTrans.frommRNAtoDNA(stringValue)))
        case 1: longInput.changeCaseOfLetter(self)
        case 0: longInput.textStorage?.setAttributedString(NSAttributedString(string: bioTrans.frommRNAtoEnglish(stringValue)))
        default: return
        }
    }
    
    func checkPossibleConversionAndConvertEnglish() {
        
        // No guard -- English has no default constraints
        switch longOutputSelection.selectedSegment {
        case 0: longInput.textStorage?.setAttributedString(NSAttributedString(string: bioTrans.fromEnglishtoDNA(stringValue)))
        case 1: longInput.textStorage?.setAttributedString(NSAttributedString(string: bioTrans.fromEnglishtomRNA(stringValue)))
        case 2: longInput.changeCaseOfLetter(self)
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
//        if (alertResponse == NSAlertSecondButtonReturn) {
//            longInput.stringValue = ""
//            longOutputSelection.setSelected(false, forSegment: longOutputSelection.selectedSegment)
//        } else if (alertResponse == NSAlertThirdButtonReturn) {
//            longInput.stringValue = ""
//            longOutput.stringValue = ""
//            longOutputSelection.setSelected(false, forSegment: longOutputSelection.selectedSegment)
//        }
        
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
        
        stringValue = (longInput.textStorage! as NSAttributedString).string
        
        // Notification when preference is changed
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(preferencesDidUpdate), name: "preferencesDidUpdate", object: nil)
        
    }
    
    // Updates buttons to reflect change in NSUserDefaults without restart
    func preferencesDidUpdate() {
        longInputSelection.selectedSegment = NSUserDefaults.standardUserDefaults().valueForKey("defaultInputSelection") as! Int
        longOutputSelection.selectedSegment = NSUserDefaults.standardUserDefaults().valueForKey("defaultOutputSelection") as! Int
    }
    
    
    override var representedObject: AnyObject? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    
}
