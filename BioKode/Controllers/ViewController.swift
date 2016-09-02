//
//  ViewController.swift
//  StoryboardTest
//
//  Created by Peter Kos on 4/24/16.
//  Copyright © 2016 Peter Kos. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
	
	// Error checking & conversion objects to be used later
	let errorCheck = ErrorCheck()
	var alert = NSAlert()
	let bioTrans = BioTranslate()
	
    
    // Input and output text fields
    @IBOutlet weak var inputStr: NSTextField!
    @IBOutlet weak var outputStr: NSTextField!
    
    // Input and output conversion selection
    @IBOutlet weak var inputSegments: NSSegmentedControl!
    @IBOutlet weak var outputSegments: NSSegmentedControl!
	
	@IBAction func resetButton(sender: AnyObject) {
	
		inputSegments.setSelected(false, forSegment: inputSegments.selectedSegment)
		outputSegments.setSelected(false, forSegment: outputSegments.selectedSegment)
	
		inputStr.stringValue = ""
		outputStr.stringValue = ""
		
	}
	
    @IBAction func inputIsSelected(sender: NSSegmentedControl) {
        
        // Replaces placeholder text
        if (inputSegments.selectedSegment == 0) {
            inputStr.placeholderString = "ACTGCGGTCGAC"
        } else if (inputSegments.selectedSegment == 1) {
            inputStr.placeholderString = "ACUGCGGUCGAC"
        } else {
            inputStr.placeholderString = "Cookie"
        }
		
		
		// If an output cell is selected, deselect it.
		if (outputSegments.selectedSegment != -1) {
			outputSegments.setSelected(false, forSegment: outputSegments.selectedSegment)
		}
		
    }
	
    @IBAction func outputIsSelected(sender: NSSegmentedControl) {
		
		guard !errorCheck.stringIsNotEmpty(inputStr.stringValue) else {
			invalidEmptyInput()
			return
		}
		
        // 0 = DNA, 1 = mRNA, 2 = English
        if (inputSegments.selectedSegment == 0) {
            checkPossibleConversionAndConvertDNA()
        } else if (inputSegments.selectedSegment == 1) {
            checkPossibleConversionAndConvertmRNA()
        } else if (inputSegments.selectedSegment == 2) {
            checkPossibleConversionAndConvertEnglish()
        }
        
    }

	
	// MARK: - Error checking & calculation functions for input
	
    func checkPossibleConversionAndConvertDNA() {
		
        guard !errorCheck.isValidDNA(inputStr.stringValue) else {
             invalidDNASequence()
            return
        }
        
        switch outputSegments.selectedSegment {
			case 0: outputStr.stringValue = inputStr.stringValue.uppercaseString;
			case 1: outputStr.stringValue = bioTrans.fromDNAtomRNA(inputStr.stringValue)
			case 2: outputStr.stringValue = bioTrans.fromDNAtoEnglish(inputStr.stringValue)
			default: return
        }
    }
    
    func checkPossibleConversionAndConvertmRNA() {

        guard !errorCheck.isValidmRNA(inputStr.stringValue) else {
			invalidmRNASequence()
            return
        }
        
        switch outputSegments.selectedSegment {
			case 0: outputStr.stringValue = bioTrans.frommRNAtoDNA(inputStr.stringValue)
			case 1: outputStr.stringValue = inputStr.stringValue.uppercaseString
			case 2: bioTrans.frommRNAtoEnglish(inputStr.stringValue)
			default: return
        }
    }
    
    func checkPossibleConversionAndConvertEnglish() {
        
        // No guard -- English has no default constraints
        switch outputSegments.selectedSegment {
			case 0: outputStr.stringValue = bioTrans.fromEnglishtoDNA(inputStr.stringValue)
			case 1: outputStr.stringValue = bioTrans.fromEnglishtomRNA(inputStr.stringValue)
			case 2: outputStr.stringValue = inputStr.stringValue.uppercaseString
			default: return
        }
    }
	
	
	// MARK: Error delegate functions
	
	func alertButtonsAndActions() {
		alert.addButtonWithTitle("OK")
		alert.addButtonWithTitle("Clear Input")
		alert.addButtonWithTitle("Clear Input & Output")
		let alertResponse = alert.runModal()
		
		// SecondButton = clear in, ThirdButton = clear in & out
		// Output segments are cleared either way to allow user to re-apply conversion.
		if (alertResponse == NSAlertSecondButtonReturn) {
			inputStr.stringValue = ""
			outputSegments.setSelected(false, forSegment: outputSegments.selectedSegment)
		} else if (alertResponse == NSAlertThirdButtonReturn) {
			inputStr.stringValue = ""
			outputStr.stringValue = ""
			outputSegments.setSelected(false, forSegment: outputSegments.selectedSegment)
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

	
	// MARK: - ViewDidLoad & Others
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		// Notification when preference is changed
		NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(preferencesDidUpdate), name: "preferencesDidUpdate", object: nil)
		
    }
	
	
	// Updates buttons to reflect change in NSUserDefaults without restart
	func preferencesDidUpdate() {
		inputSegments.selectedSegment = NSUserDefaults.standardUserDefaults().valueForKey("defaultInputSelection") as! Int
		outputSegments.selectedSegment = NSUserDefaults.standardUserDefaults().valueForKey("defaultOutputSelection") as! Int
	}


}

