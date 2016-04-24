//
//  BioTranslate.swift
//  BioKode
//
//  Created by Peter Kos on 4/21/16.
//  Copyright © 2016 Peter Kos. All rights reserved.
//

import Cocoa

class BioTranslate {
    
    // mRNA ****************
    func fromDNAtomRNA(input input: NSTextField, output: NSTextField) {
        
        // Resets output
        output.stringValue = ""
        
        // Gets input text
        let textIn = input.stringValue.uppercaseString
        
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
    
    func fromDNAtoEnglish(input input: NSTextField, output: NSTextField) {
        let inputPlaceholder = NSTextField()
        let outputPlaceholder = NSTextField()
        
        fromDNAtomRNA(input: input, output: inputPlaceholder)
        frommRNAtoEnglish(input: inputPlaceholder, output: outputPlaceholder)
        
        output.stringValue = outputPlaceholder.stringValue
    }
    
    
    // mRNA ****************
    func frommRNAtoDNA(input input: NSTextField, output: NSTextField) {
        
        // Resets output
        output.stringValue = ""
        
        // Gets input text
        let textIn = input.stringValue.uppercaseString
        
        // Converts to mRNA
        for i in textIn.characters {
            if (i == "A") {
                output.stringValue += "T"
            } else if (i == "G") {
                output.stringValue += "C"
            } else if (i == "C") {
                output.stringValue += "G"
            } else if (i == "U") {
                output.stringValue += "A"
            }
        }
    }
    
	func frommRNAtoEnglish(input input: NSTextField, output: NSTextField) {
        // Resets output
        output.stringValue = ""
        
        // Gets input text
        let textIn = input.stringValue.uppercaseString
        var preEnglish = [String]()
        
        // Converts to codons
        for i in 0.stride(to: textIn.characters.count, by: 3) {
            preEnglish.append(textIn.substringWithRange(textIn.startIndex.advancedBy(i)..<textIn.startIndex.advancedBy(i + 3)))
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
            default:                         inEnglish.append("$")
                
            }
        }
        
        // Outputs array to box
        for str in inEnglish {
            output.stringValue += str
        }
    }
    
    // English ****************
    func fromEnglishtomRNA(input input: NSTextField, output: NSTextField) {
        
        let inputString = input.stringValue.uppercaseString
        var outputString = String()
		
		// Dictionary mapping English letters to all possible mRNA codons
		var englishTomRNA: [Character: [String]] = ["A": ["UUU", "UAC"],
		                                         "Q": ["UUA", "UUG"],
		                                         "S": ["UCU", "UCC", "UCA", "UCG"],
		                                         "C": ["UAU", "UAC"],
		                                         "G": ["UAA", "UAG", "UGA"],
		                                         "H": ["UGU", "UGC"],
		                                         "W": ["UGG"]]
		
		// If the user selects to assign polygenetic codon values randomly, do so.
		// Otherwise, pick the first.
		if (NSUserDefaults.standardUserDefaults().valueForKey("polygeneticSelection") as! Int == 0) {
			// Random number function to make life slightly easier
			func rand(lim: Int) -> Int {
				return Int(arc4random_uniform(UInt32(lim)))
			}
			
			// Looks in dictionary, compares every English letter to every corresponding entry
			// If the entry exists, append a randomly selected entry of the String array in the dictionary
			// to the output text field string.
			for char in inputString.characters {
				if let eng: String = englishTomRNA[char]![rand(englishTomRNA[char]!.count)] {
					outputString += eng
				}
			}
		} else {
			// Looks in dictionary, compares every English letter to every corresponding entry
			for char in inputString.characters {
				if let eng: String = englishTomRNA[char]![0] {
					outputString += eng
				}
			}
		}
		
        output.stringValue = outputString
    }
    
    func fromEnglishtoDNA(input input: NSTextField, output: NSTextField) {
        let inputPlaceholder = NSTextField()
        let outputPlaceholder = NSTextField()
        
		fromEnglishtomRNA(input: input, output: inputPlaceholder)
        frommRNAtoDNA(input: inputPlaceholder, output: outputPlaceholder)
        
        output.stringValue = outputPlaceholder.stringValue
    }
    
}
