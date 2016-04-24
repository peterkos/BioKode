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
        
        // Error checking for input
        let errorCheck = ErrorCheck()
        let errorResponse = ErrorResponse(inputTextField: inputStr, inputSegments: inputSegments)
        
        // Calls appropriate conversion method.
        // Sets output to input if equal conversion languages are selected.
        // 0 = DNA, 1 = mRNA, 2 = English
        let bioTrans = BioTranslate()
        
        // DNA
        if (inputSegments.selectedSegment == 0) {
            
            guard !errorCheck.isValidDNA(inputStr.stringValue) else {
                errorResponse.invalidDNASequence()
                return
            }
            
            switch outputSegments.selectedSegment {
            case 0: outputStr.stringValue = inputStr.stringValue.uppercaseString;
            case 1: bioTrans.fromDNAtomRNA(input: inputStr, output: outputStr)
            case 2: bioTrans.fromDNAtoEnglish(input: inputStr, output: outputStr)
            default: return
            }
            
            // mRNA
        } else if (inputSegments.selectedSegment == 1) {
            
            guard !errorCheck.isValidmRNA(inputStr.stringValue) else {
                errorResponse.invalidmRNASequence()
                return
            }
            
            switch outputSegments.selectedSegment {
            case 0: bioTrans.frommRNAtoDNA(input: inputStr, output: outputStr)
            case 1: outputStr.stringValue = inputStr.stringValue.uppercaseString
            case 2: bioTrans.frommRNAtoEnglish(input: inputStr, output: outputStr)
            default: return
            }
            
            // English, valid by default
        } else if (inputSegments.selectedSegment == 2) {
            switch outputSegments.selectedSegment {
            case 0: bioTrans.fromEnglishtoDNA(input: inputStr, output: outputStr)
            case 1: bioTrans.fromEnglishtomRNA(input: inputStr, output: outputStr)
            case 2: outputStr.stringValue = inputStr.stringValue.uppercaseString
            default: return
            }
        }
        
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

