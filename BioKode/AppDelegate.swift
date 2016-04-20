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
    @IBOutlet weak var input: NSTextField!
    @IBOutlet weak var output: NSTextField!
    
    // mRNA or English Translation Mode
    @IBOutlet weak var mRNAButton: NSButton!
    @IBOutlet weak var mEnglishButton: NSButton!
    @IBAction func translationMode(sender: NSButton) {}
    
    
    var convertMethod = "";
    
    
    @IBAction func convertInput(sender: AnyObject) {
        if (mRNAButton.state == 1) {
            convertInput_mRNA();
        } else {
            convertInput_mEnglish();
        }
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
    
    func convertInput_mEnglish() {
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
                case "UUU": inEnglish.append("A");
                case "UUC": inEnglish.append("A");
                case "UUA": inEnglish.append("Q");
                case "UUG": inEnglish.append("Q");
                // UC
                case "UCU": inEnglish.append("S");
                case "UCC": inEnglish.append("S");
                case "UCA": inEnglish.append("S");
                case "UCG": inEnglish.append("S");
                // UA
                case "UAU": inEnglish.append("C");
                case "UAC": inEnglish.append("C");
                case "UAA": inEnglish.append("G");
                case "UAG": inEnglish.append("G");
                // UG
                case "UGU": inEnglish.append("H");
                case "UGC": inEnglish.append("H");
                case "UGA": inEnglish.append("G");
                case "UGG": inEnglish.append("W");
                    
                // C *****************************
                // CU
                case "CUU": inEnglish.append("N");
                case "CUC": inEnglish.append("N");
                case "CUA": inEnglish.append("N");
                case "CUG": inEnglish.append("N");
                // CC
                case "CCU": inEnglish.append("R");
                case "CCC": inEnglish.append("R");
                case "CCA": inEnglish.append("R");
                case "CCG": inEnglish.append("R");
                // CA
                case "CAU": inEnglish.append("L");
                case "CAC": inEnglish.append("L");
                case "CAA": inEnglish.append("I");
                case "CAG": inEnglish.append("I");
                // CG
                case "CGU": inEnglish.append("D");
                case "CGC": inEnglish.append("D");
                case "CGA": inEnglish.append("D");
                case "CGG": inEnglish.append("D");
                    
                // A *****************************
                // AU
                case "AUU": inEnglish.append("M");
                case "AUC": inEnglish.append("M");
                case "AUA": inEnglish.append("M");
                case "AUG": inEnglish.append("P");
                // AC
                case "ACU": inEnglish.append("V");
                case "ACC": inEnglish.append("V");
                case "ACA": inEnglish.append("T");
                case "ACG": inEnglish.append("T");
                // AA
                case "AAU": inEnglish.append("E");
                case "AAC": inEnglish.append("E");
                case "AAA": inEnglish.append("O");
                case "AAG": inEnglish.append("O");
                // AG
                case "AGU": inEnglish.append("S");
                case "AGC": inEnglish.append("S");
                case "AGA": inEnglish.append("D");
                case "AGG": inEnglish.append("D");
                    
                // G *****************************
                // GU
                case "GUU": inEnglish.append("Z");
                case "GUC": inEnglish.append("Z");
                case "GUA": inEnglish.append("Y");
                case "GUG": inEnglish.append("Y");
                // GC
                case "GCU": inEnglish.append("U");
                case "GCC": inEnglish.append("U");
                case "GCA": inEnglish.append("B");
                case "GCG": inEnglish.append("B");
                // GA
                case "GAU": inEnglish.append("F");
                case "GAC": inEnglish.append("F");
                case "GAA": inEnglish.append("J");
                case "GAG": inEnglish.append("J");
                // GG
                case "GGU": inEnglish.append("K");
                case "GGC": inEnglish.append("K");
                case "GGA": inEnglish.append("K");
                case "GGG": inEnglish.append("K");
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
