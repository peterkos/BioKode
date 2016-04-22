//
//  BioTranslate.swift
//  BioKode
//
//  Created by Peter Kos on 4/21/16.
//  Copyright © 2016 Peter Kos. All rights reserved.
//

import Cocoa

class BioTranslate {
    
    // Converts from DNA into mRNA
    func fromDNAtomRNA(input input: NSTextField, output: NSTextField) {
        
        // Resets output
        output.stringValue = ""
        
        // Gets input text
        let textIn = String(input.stringValue)
        
        // Converts to mRNA
        for i in textIn.characters {
            if (i == "T") {
                output.stringValue += "A"
            } else if (i == "C") {
                output.stringValue += "G"
            } else if (i == "G") {
                output.stringValue += "C"
            } else if (i == "A") {
                output.stringValue += "U"
            }
        }
    }
    
    // Converts from mRNA into English
    func frommRNAtoEnglish(input input: NSTextField, output: NSTextField) {
        // Resets output
        output.stringValue = ""
        
        // Gets input text
        let textIn = String(input.stringValue)
        var preEnglish = [String]()
        
        // Converts to codons
        for i in 0.stride(to: textIn.characters.count, by: 3) {
            preEnglish.append(textIn[i..<(i + 3)])
        }
        
        // Creates final array, converts to English
        var inEnglish = [String]()
        for str in preEnglish {
            switch str {
                // U *****************************
            // UU
            case "UUU", "UAC":               inEnglish.append("A")
            case "UUA", "UUG":               inEnglish.append("Q")
            // UC
            case "UCU", "UCC", "UCA", "UCG": inEnglish.append("S")
            // UA
            case "UAU", "UAC":               inEnglish.append("C")
            case "UAA", "UAG":               inEnglish.append("G")
                
            // UG
            case "UGU", "UGC":               inEnglish.append("H")
            case "UGA":                      inEnglish.append("G")
            case "UGG":                      inEnglish.append("W")
                
                // C *****************************
            // CU
            case "CUU", "CUC", "CUA", "CUG": inEnglish.append("N")
            // CC
            case "CCU", "CCC", "CCA", "CCG": inEnglish.append("R")
            // CA
            case "CAU", "CAC":               inEnglish.append("L")
            case "CAA", "CAG":               inEnglish.append("I")
            // CG
            case "CGU", "CGC", "CGA", "CGG": inEnglish.append("D")
                
                // A *****************************
            // AU
            case "AUU", "AUC", "AUA":        inEnglish.append("M")
            case "AUG":                      inEnglish.append("P")
            // AC
            case "ACU", "ACC":               inEnglish.append("V")
            case "ACA", "ACG":               inEnglish.append("T")
            // AA
            case "AAU", "AAC":               inEnglish.append("E")
            case "AAA", "AAG":               inEnglish.append("O")
            // AG
            case "AGU", "AGC":               inEnglish.append("S")
            case "AGA", "AGG":               inEnglish.append("D")
                
                // G *****************************
            // GU
            case "GUU", "GUC":               inEnglish.append("Z")
            case "GUA", "GUG":               inEnglish.append("Y")
            // GC
            case "GCU", "GCC":               inEnglish.append("U")
            case "GCA", "GCG":               inEnglish.append("B")
            // GA
            case "GAU", "GAC":               inEnglish.append("F")
            case "GAA", "GAG":               inEnglish.append("J")
            // GG
            case "GGU", "GGC", "GGA", "GGG": inEnglish.append("K")
            default   : inEnglish.append("$")
                
            }
        }
        
        // Outputs array to box
        for str in inEnglish {
            output.stringValue += str
        }
    }

    
}