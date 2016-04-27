//
//  ViewController.swift
//  StoryboardTest
//
//  Created by Peter Kos on 4/24/16.
//  Copyright © 2016 Peter Kos. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    
    // Input and output text fields
    @IBOutlet weak var inputStr: NSTextField!
    @IBOutlet weak var outputStr: NSTextField!
    
    // Input and output conversion selection
    @IBOutlet weak var inputSegments: NSSegmentedControl!
    @IBOutlet weak var outputSegments: NSSegmentedControl!
    
    @IBAction func inputIsSelected(sender: NSSegmentedControl) {
        
        // Insert placeholder text
        if (inputSegments.selectedSegment == 0) {
            inputStr.placeholderString = "ACTGCGGTCGAC"
        } else if (inputSegments.selectedSegment == 1) {
            inputStr.placeholderString = "ACUGCGGUCGAC"
        } else {
            inputStr.placeholderString = "Cookie"
        }
        
    }
    
    @IBAction func outputIsSelected(sender: NSSegmentedControl) {
		
        // 0 = DNA, 1 = mRNA, 2 = English
		// If the output is selected and no input is selected,
		// prompt the user.
        if (inputSegments.selectedSegment == 0) {
            checkPossibleConversionAndConvertDNA()
        } else if (inputSegments.selectedSegment == 1) {
            checkPossibleConversionAndConvertmRNA()
        } else if (inputSegments.selectedSegment == 2) {
            checkPossibleConversionAndConvertEnglish()
        }
        
    }

	// ----------------------------------------------
	// Custom Functions
	// ----------------------------------------------
	
	// Error checking objects
	let errorCheck = ErrorCheck()
	let bioTrans = BioTranslate()
	
    // Error checking & calculation functions for input
    func checkPossibleConversionAndConvertDNA() {
        guard !errorCheck.isValidDNA(inputStr.stringValue) else {
            ErrorResponse(inputTextField: inputStr,
                          inputSegments: inputSegments,
                          outputSegments: outputSegments).invalidDNASequence()
            return
        }
        
        switch outputSegments.selectedSegment {
        case 0: outputStr.stringValue = inputStr.stringValue.uppercaseString;
        case 1: bioTrans.fromDNAtomRNA(input: inputStr, output: outputStr)
        case 2: bioTrans.fromDNAtoEnglish(input: inputStr, output: outputStr)
        default: return
        }
    }
    
    func checkPossibleConversionAndConvertmRNA() {
        guard !errorCheck.isValidmRNA(inputStr.stringValue) else {
            ErrorResponse(inputTextField: inputStr,
                          inputSegments: inputSegments,
                          outputSegments: outputSegments).invalidmRNASequence()
            return
        }
        
        switch outputSegments.selectedSegment {
			case 0: bioTrans.frommRNAtoDNA(input: inputStr, output: outputStr)
			case 1: outputStr.stringValue = inputStr.stringValue.uppercaseString
			case 2: bioTrans.frommRNAtoEnglish(input: inputStr, output: outputStr)
			
			default: return
        }
    }
    
    func checkPossibleConversionAndConvertEnglish() {
        
        // No guard -- English has no default constraints
        switch outputSegments.selectedSegment {
        case 0: bioTrans.fromEnglishtoDNA(input: inputStr, output: outputStr)
        case 1: bioTrans.fromEnglishtomRNA(input: inputStr, output: outputStr)
        case 2: outputStr.stringValue = inputStr.stringValue.uppercaseString
        default: return
        }
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
		inputSegments.selectedSegment = NSUserDefaults.standardUserDefaults().valueForKey("defaultInputSelection") as! Int
		outputSegments.selectedSegment = NSUserDefaults.standardUserDefaults().valueForKey("defaultOutputSelection") as! Int
	}
	

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

