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
        if (mRNAButton.state == 1) {
            convertInput_mRNA(input: inputStr, output: outputStr);
        } else if (mEnglishButton.state == 1) {
            convertInput_mEnglish(input: inputStr, output: outputStr);
        } else {
            let mRNAIntermediateOutput = (NSTextField)();
            convertInput_mRNA(input: inputStr, output: mRNAIntermediateOutput);
            convertInput_mEnglish(input: mRNAIntermediateOutput, output: outputStr);
        }
    }
    
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {}
        
    
    func convertInput_mRNA(input input: NSTextField, output: NSTextField) {
        
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
    
    func convertInput_mEnglish(input input: NSTextField, output: NSTextField) {
        // Resets output
        output.stringValue = "";
        
        // Gets input text
        let textIn = String(input.stringValue);
        var preEnglish = [String]();
        
        // Converts to codons
        for i in 0.stride(to: textIn.characters.count, by: 3) {
            preEnglish.append(textIn[i..<(i + 3)]);
        }
        
        // Creates final array, converts to English
        var inEnglish = [String]();
        for str in preEnglish {
            switch str {
                // U *****************************
                // UU
                case "UUU", "UAC":               inEnglish.append("A");
                case "UUA", "UUG":               inEnglish.append("Q");
                // UC
                case "UCU", "UCC", "UCA", "UCG": inEnglish.append("S");
                // UA
                case "UAU", "UAC":               inEnglish.append("C");
                case "UAA", "UAG":               inEnglish.append("G");

                // UG
                case "UGU", "UCG":               inEnglish.append("H");
                case "UGA":                      inEnglish.append("G");
                case "UGG":                      inEnglish.append("W");
                    
                // C *****************************
                // CU
                case "CUU", "CUC", "CUA", "CUG": inEnglish.append("N");
                // CC
                case "CCU", "CCC", "CCA", "CCG": inEnglish.append("R");
                // CA
                case "CAU", "CAC":               inEnglish.append("L");
                case "CAA", "CAG":               inEnglish.append("I");
                // CG
                case "CGU", "CGC", "CGA", "CGG": inEnglish.append("D");
                    
                // A *****************************
                // AU
                case "AUU", "AUC", "AUA":        inEnglish.append("M");
                case "AUG":                      inEnglish.append("P");
                // AC
                case "ACU", "ACC":               inEnglish.append("V");
                case "ACA", "ACG":               inEnglish.append("T");
                // AA
                case "AAU", "AAC":               inEnglish.append("E");
                case "AAA", "AAG":               inEnglish.append("O");
                // AG
                case "AGU", "AGC":               inEnglish.append("S");
                case "AGA", "AGG":               inEnglish.append("D");
                    
                // G *****************************
                // GU
                case "GUU", "GUC":               inEnglish.append("Z");
                case "GUA", "GUG":               inEnglish.append("Y");
                // GC
                case "GCU", "GCC":               inEnglish.append("U");
                case "GCA", "GCG":               inEnglish.append("B");
                // GA
                case "GAU", "GAC":               inEnglish.append("F");
                case "GAA", "GAG":               inEnglish.append("J");
                // GG
                case "GGU", "GGC", "GGA", "GGG": inEnglish.append("K");
                default   : inEnglish.append("$");
            }
        }
        
        // Outputs array to box
        for str in inEnglish {
            output.stringValue += str;
        }
    } // End of func
    
    
    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


}
