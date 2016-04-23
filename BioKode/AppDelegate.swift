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
        
        // If input isn't of a valid length (i.e., not a multiple of 3), prompt the user
        guard checkInputSize(inputStr.stringValue) else {
            let alert = NSAlert()
            alert.messageText = "Uh oh!"
            alert.informativeText = "Invalid sequence. Should be a multiple of 3."
            alert.addButtonWithTitle("OK")
            alert.addButtonWithTitle("Clear Input")
            let alertResponse = alert.runModal()
            
            // Reset the input field if the "Clear Input" button is selected
            if (alertResponse == NSAlertSecondButtonReturn) {
                inputStr.stringValue = ""
            }
            
            for i in 0..<inputSegments.segmentCount {
                inputSegments.setSelected(false, forSegment: i)
            }
            
            return
        }
        
        // If input isn't of a valid quality (i.e., contains non-DNA nucleotides), prompt the user
        guard checkIfInputIsDNA(inputStr.stringValue) else {
            let alert = NSAlert()
            alert.messageText = "Uh oh!"
            alert.informativeText = "Invalid sequence. Valid nucleotides are A, C, T, and G."
            alert.addButtonWithTitle("OK")
            alert.addButtonWithTitle("Clear Input")
            let alertResponse = alert.runModal()
        
            // Reset the input field if the "Clear Input" button is selected
            if (alertResponse == NSAlertSecondButtonReturn) {
                inputStr.stringValue = ""
            }
            
            for i in 0..<inputSegments.segmentCount {
                inputSegments.setSelected(false, forSegment: i)
            }
            
            return
        }
        
        
        // Calls appropriate conversion method.
        // Sets output to input if equal conversion languages are selected.
        // 0 = DNA, 1 = mRNA, 2 = English
        let bioTrans = BioTranslate()
        
        if (inputSegments.selectedSegment == 0) {
            switch outputSegments.selectedSegment {
                case 0: outputStr.stringValue = inputStr.stringValue;
                case 1: bioTrans.fromDNAtomRNA(input: inputStr, output: outputStr)
                case 2: bioTrans.fromDNAtoEnglish(input: inputStr, output: outputStr)
                default: print("UH OH 0")
            }
            
        } else if (inputSegments.selectedSegment == 1) {
            switch outputSegments.selectedSegment {
                case 0: bioTrans.frommRNAtoDNA(input: inputStr, output: outputStr)
                case 1: outputStr.stringValue = inputStr.stringValue
                case 2: bioTrans.frommRNAtoEnglish(input: inputStr, output: outputStr)
                default: print("UH OH 1")
            }
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
    
    // Checks to see if a given input is a multiple of 3 (to be a valid "codon")
    func checkInputSize(input: String) -> Bool {
        if (input.characters.count % 3 != 0) {
            let outOfBoundsAlert = NSAlert()
            outOfBoundsAlert.addButtonWithTitle("Oops!")
            return false
        } else {
            return true
        }
        
    }
    
    // Checks to see if given input is a DNA string
    func checkIfInputIsDNA(input: String) -> Bool {
        for char in input.characters {
            if (char != "A" && char != "T" && char != "C" && char != "G") {
                return false
            }
        }
        
        return true
        
    }
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {}
        
    
    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }

}
