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
    @IBOutlet weak var mRNAButton: NSButton!
    @IBOutlet weak var mEnglishButton: NSButton!
    @IBOutlet weak var mBothButton: NSButton!
    @IBAction func translationMode(sender: NSButton) {
        
        let bioTrans = BioTranslate()
        
        if (mRNAButton.state == 1) {
            bioTrans.convertInput_mRNA(input: inputStr, output: outputStr)
        } else if (mEnglishButton.state == 1) {
            bioTrans.convertInput_mEnglish(input: inputStr, output: outputStr)
        } else {
            let mRNAIntermediateOutput = (NSTextField)()
            bioTrans.convertInput_mRNA(input: inputStr, output: mRNAIntermediateOutput)
            bioTrans.convertInput_mEnglish(input: mRNAIntermediateOutput, output: outputStr)
        }
    }
    
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {}
        
    
    
    
    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


}
