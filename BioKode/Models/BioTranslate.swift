//
//  BioTranslate.swift
//  BioKode
//
//  Created by Peter Kos on 4/21/16.
//  Copyright © 2016 Peter Kos. All rights reserved.
//

import Cocoa

class BioTranslate {
	
	let englishTomRNADictionary: [Character: [String]] =
		["A": ["UUU", "UAC"],
		 "Q": ["UUA", "UUG"],
		 "S": ["UCU", "UCC", "UCA", "UCG", "AGU", "AGC"],
		 "C": ["UAU", "UAC"],
		 "G": ["UAA", "UAG", "UGA"],
		 "H": ["UGU", "UGC"],
		 "W": ["UGG"],
		 "N": ["CUU", "CUC", "CUA", "CUG"],
		 "R": ["CCU", "CCC", "CCA", "CCG"],
		 "L": ["CAU", "CAC"],
		 "I": ["CAA", "CAG"],
		 "D": ["AGA", "AGG", "CGU", "CGC", "CGA", "CGG"],
		 "M": ["AUU", "AUC"],
		 "X": ["AUA"],
		 "P": ["AUG"],
		 "V": ["ACU", "ACC"],
		 "T": ["ACA", "ACG"],
		 "E": ["AAU", "AAC"],
		 "O": ["AAA", "AAG"],
		 "Z": ["GUU", "GUC"],
		 "Y": ["GUA", "GUG"],
		 "U": ["GCU", "GCC"],
		 "B": ["GCA", "GCG"],
		 "F": ["GAU", "GAC"],
		 "J": ["GAA", "GAG"],
		 "K": ["GGU", "GGC", "GGA", "GGG"]]
	
	
    // MARK: - DNA -> mRNA
    func fromDNAtomRNA(input: String) -> String {
        
        // Resets output
        var outputString = ""
        
        // Gets input text
        let textIn = input.uppercaseString
        
        // Converts to mRNA
        for i in textIn.characters {
            if (i == "T") {
				outputString += "A"
            } else if (i == "C") {
                outputString += "G"
            } else if (i == "G") {
                outputString += "C"
            } else if (i == "A") {
                outputString += "U"
            }
        }
		
		return outputString
    }
    
	func fromDNAtoEnglish(input: String) -> String {
		let inputPlaceholderString: String
		let outputPlaceholderString: String
			
        inputPlaceholderString = fromDNAtomRNA(input)
		outputPlaceholderString = frommRNAtoEnglish(inputPlaceholderString)
        
        return outputPlaceholderString
    }
    
    
    // MARK: RNA -> DNA, English
    func frommRNAtoDNA(input: String) -> String {
        
        // Resets output
        var outputString = ""
        let inputString = input.uppercaseString
        
        // Converts to mRNA
        for i in inputString.characters {
            if (i == "A") {
                outputString += "T"
            } else if (i == "G") {
                outputString += "C"
            } else if (i == "C") {
                outputString += "G"
            } else if (i == "U") {
                outputString += "A"
            }
        }
		
		return outputString
    }
    
	func frommRNAtoEnglish(input: String) -> String {
        
        // Gets input text
		var outputString = ""
		let inputString = input.uppercaseString
        var preEnglish = [String]()
        
        // Converts to codons (groups of 3)
        for i in 0.stride(to: inputString.characters.count, by: 3) {
            preEnglish.append(inputString.substringWithRange(inputString.startIndex.advancedBy(i)..<inputString.startIndex.advancedBy(i + 3)))
        }
		
        // Preconditoin: codon is a valid RNA sequence
		// Credit: http://stackoverflow.com/a/36854223/1431900
		// Reverse-map the codon (as a value) from the englishTomRNADictionary to the key (corresponding English letter), and append the key to the outputString
		for codon in preEnglish {
			let english = englishTomRNADictionary.filter { $0.1.contains(codon) }.first!.0
			outputString.append(english)
		}
		
		return outputString
    }
	

	// MARK: - English -> mRNA, DNA
	func fromEnglishtomRNA(input: String) -> String {
        
		var outputString = String()
		let inputString = input.uppercaseString
		
		
			// Random number function to make life slightly easier
			func rand(lim: Int) -> Int {
				return Int(arc4random_uniform(UInt32(lim)))
			}
			
			// Looks in dictionary, compares every English letter to every corresponding entry.
			for char: Character in inputString.characters {
				if let codonArr = englishTomRNADictionary[char] {
		
					// If the user selects to assign polygenetic codon values randomly, do so.
					// Otherwise, pick the first.
					if (NSUserDefaults.standardUserDefaults().valueForKey("polygeneticSelection") as! Int == 2) {
						outputString += codonArr[rand(codonArr.count)]
					} else {
						outputString += codonArr[0]
					}
				}
			}
		
         return outputCodon(outputString)
    }
    
    func fromEnglishtoDNA(input: String) -> String {
		let inputPlaceholderString: String
		let outputPlaceholderString: String
		
		inputPlaceholderString = fromEnglishtomRNA(input)
		outputPlaceholderString = frommRNAtoDNA(inputPlaceholderString)
		
        return outputCodon(outputPlaceholderString)
    }
	
	
	func outputCodon(input: String) -> String {
		
		var outputString = ""
		
		if (NSUserDefaults.standardUserDefaults().valueForKey("outputSpacingSelection") as! Int == 2) {
			for i in 0.stride(to: input.characters.count, by: 3) {
				outputString += (input.substringWithRange(input.startIndex.advancedBy(i)..<input.startIndex.advancedBy(i + 3)) + "-")
			}
			
			// Exclude trailing dash
			outputString = String(outputString.characters.dropLast(1))
		} else {
			for i in 0.stride(to: input.characters.count, by: 3) {
				outputString += (input.substringWithRange(input.startIndex.advancedBy(i)..<input.startIndex.advancedBy(i + 3)))
			}
		}
		
		return outputString
	}
	
}
