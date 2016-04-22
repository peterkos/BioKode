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
    
    // mRNA or English Translation Mode
//    @IBOutlet weak var mRNAButton: NSButton!
//    @IBOutlet weak var mEnglishButton: NSButton!
    @IBOutlet weak var inputSegments: NSSegmentedControl!
    
    @IBAction func inputPlaceholderTextGenerator(sender: AnyObject) {
        
        // Insert placeholder text
        if (inputSegments.selectedSegment == 0) {
            inputStr.placeholderString = "ACTGCGGTCGAC"
        } else if (inputSegments.selectedSegment == 1) {
            inputStr.placeholderString = "ACUGCGGUCGAC"
        } else {
            inputStr.placeholderString = "Cookie"
        }
        
    }
    
    @IBAction func translationMode(sender: AnyObject) {
        
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
        
        
        // The actual selection of which conversion method to use
        let bioTrans = BioTranslate()
        
        if (inputSegments.isSelectedForSegment(0)) {
            bioTrans.fromDNAtomRNA(input: inputStr, output: outputStr)
        } else if (inputSegments.isSelectedForSegment(1)) {
            let mRNAIntermediateOutput = NSTextField()
            bioTrans.fromDNAtomRNA(input: inputStr, output: mRNAIntermediateOutput)
            bioTrans.frommRNAtoEnglish(input: mRNAIntermediateOutput, output: outputStr)
        } else {
            
            
        }
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
