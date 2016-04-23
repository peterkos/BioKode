//
//  AppDelegate.swift
//  BioKode
//
//  Created by Peter Kos on 4/19/16.
//  Copyright © 2016 Peter Kos. All rights reserved.
//

import Cocoa

// Source for String extension: http://stackoverflow.com/a/24144365
extension String {
    
    subscript (i: Int) -> Character {
        return self[self.startIndex.advancedBy(i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    subscript (r: Range<Int>) -> String {
        let start = startIndex.advancedBy(r.startIndex)
        let end = start.advancedBy(r.endIndex - r.startIndex)
        return self[Range(start ..< end)]
    }
}


@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    
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
        
        print("Selected segment: \(inputSegments.selectedSegment)")
        
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
                case 0: outputStr.stringValue = inputStr.stringValue;
                case 1: bioTrans.fromDNAtomRNA(input: inputStr, output: outputStr)
                case 2: bioTrans.fromDNAtoEnglish(input: inputStr, output: outputStr)
                default: print("UH OH 0")
            }
            
        // mRNA
        } else if (inputSegments.selectedSegment == 1) {
            
            guard !errorCheck.isValidmRNA(inputStr.stringValue) else {
                errorResponse.invalidmRNASequence()
                return
            }
            
            switch outputSegments.selectedSegment {
                case 0: bioTrans.frommRNAtoDNA(input: inputStr, output: outputStr)
                case 1: outputStr.stringValue = inputStr.stringValue
                case 2: bioTrans.frommRNAtoEnglish(input: inputStr, output: outputStr)
                default: print("UH OH 1")
            }
            
        // English, valid by default
        } else if (inputSegments.selectedSegment == 2) {
            switch outputSegments.selectedSegment {
                case 0: bioTrans.fromEnglishtoDNA(input: inputStr, output: outputStr)
                case 1: bioTrans.fromEnglishtomRNA(input: inputStr, output: outputStr)
                case 2: outputStr.stringValue = inputStr.stringValue
                default: print("UH OH 2")
            }
        }
        
        print("Selected \(inputSegments.selectedSegment) as input")
        print("Selected \(outputSegments.selectedSegment) as output")
        print("=======================")
        
    }

    
    func applicationDidFinishLaunching(aNotification: NSNotification) {}
        
    
    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }

}
