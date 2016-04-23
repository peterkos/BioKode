//
//  ErrorResponse.swift
//  BioKode
//
//  Created by Peter Kos on 4/22/16.
//  Copyright © 2016 Peter Kos. All rights reserved.
//

import Cocoa

class ErrorResponse {
    
    var inputTextField : NSTextField
    var inputSegments  : NSSegmentedControl
    
    init(inputTextField: NSTextField, inputSegments: NSSegmentedControl) {
        self.inputTextField = inputTextField
        self.inputSegments = inputSegments
    }
    
    
    func invalidDNASequence() {
        let alert = NSAlert()
        alert.messageText = "Uh oh!"
        alert.informativeText = "Invalid sequence. Must contain A, C, T, or G, and the total length must be a multiple of 3."
        alert.addButtonWithTitle("OK")
        alert.addButtonWithTitle("Clear Input")
        let alertResponse = alert.runModal()
        
        // Reset the input field if the "Clear Input" button is selected
        if (alertResponse == NSAlertSecondButtonReturn) {
            inputTextField.stringValue = ""
        }
        
        for i in 0..<inputSegments.segmentCount {
            inputSegments.setSelected(false, forSegment: i)
        }
        
    }
    
    func invalidmRNASequence() {
        let alert = NSAlert()
        alert.messageText = "Uh oh!"
        alert.informativeText = "Invalid sequence. Must contain A, C, U, or G, and the total length must be a multiple of 3."
        alert.addButtonWithTitle("OK")
        alert.addButtonWithTitle("Clear Input")
        let alertResponse = alert.runModal()
        
        // Reset the input field if the "Clear Input" button is selected
        if (alertResponse == NSAlertSecondButtonReturn) {
            inputTextField.stringValue = ""
        }
        
        for i in 0..<inputSegments.segmentCount {
            inputSegments.setSelected(false, forSegment: i)
        }
        
    }
    
    
    
    
}
