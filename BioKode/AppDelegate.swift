//
//  AppDelegate.swift
//  BioKode
//
//  Created by Peter Kos on 4/19/16.
//  Copyright © 2016 Peter Kos. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    
    // Input and output text fields
    @IBOutlet weak var input: NSTextField!
    @IBOutlet weak var output: NSTextField!
    
    // mRNA or English Translation Mode
    @IBOutlet weak var mRNAButton: NSButton!
    @IBOutlet weak var mEnglishButton: NSButton!
    @IBAction func translationMode(sender: NSButton) {}
    
    
    
    var convertMethod = "";
    
    
    @IBAction func convertInput(sender: AnyObject) {
        convertInput_mRNA();
    }
    
        
    func applicationDidFinishLaunching(aNotification: NSNotification) {
}
        
        
    func convertInput_mRNA() {
        // Resets output
        output.stringValue = "";
        
        // Gets input text
        let textIn = String(input.stringValue);
        
        // Converts to mRNA
        for i in textIn.characters {
            if (i == "T") {
                output.stringValue += "A";
            } else if (i == "C") {
                output.stringValue += "G";
            } else if (i == "G") {
                output.stringValue += "C";
            } else if (i == "A") {
                output.stringValue += "U";
            }
        }
    }
        

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


}

