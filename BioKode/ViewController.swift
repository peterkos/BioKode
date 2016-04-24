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
    
    @IBAction func inputPlaceholderTextGenerator(sender: NSSegmentedControl) {
        
        // Insert placeholder text
        if (inputSegments.selectedSegment == 0) {
            inputStr.placeholderString = "ACTGCGGTCGAC"
        } else if (inputSegments.selectedSegment == 1) {
            inputStr.placeholderString = "ACUGCGGUCGAC"
        } else {
            inputStr.placeholderString = "Cookie"
        }
        
    }
    
    @IBAction func translationMode(sender: NSSegmentedControl) {
        
        // Calls appropriate conversion method.
        // Sets output to input if equal conversion languages are selected.
        // 0 = DNA, 1 = mRNA, 2 = English
        
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
            ErrorResponse(inputTextField: inputStr, inputSegments: inputSegments).invalidDNASequence()
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
            ErrorResponse(inputTextField: inputStr, inputSegments: inputSegments).invalidmRNASequence()
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
		
		inputSegments.selectedSegment = NSUserDefaults.standardUserDefaults().valueForKey("defaultInputSelection") as! Int
		outputSegments.selectedSegment = NSUserDefaults.standardUserDefaults().valueForKey("defaultOutputSelection") as! Int
		
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

