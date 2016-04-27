//
//  ErrorCheck.swift
//  BioKode
//
//  Created by Peter Kos on 4/22/16.
//  Copyright © 2016 Peter Kos. All rights reserved.
//

import Cocoa


class ErrorCheck {
    
    // DNA or mRNA length must be a multiple of 3
    func isValidLength(input: String) -> Bool {
        return (input.characters.count % 3 != 0) ? false : true
    }
    
    // DNA valid character set
    func isValidDNA(input: String) -> Bool {
        func checkIfInputIsDNA(input: String) -> Bool {
            for char in input.uppercaseString.characters {
                if (char != "A" && char != "T" && char != "C" && char != "G") {
                    return false
                }
            }
            return true
        }
        
        return (checkIfInputIsDNA(input) && isValidLength(input)) ? false : true
    }
    
    
    // mRNA valid character set
    func isValidmRNA(input: String) -> Bool {
        func checkIfInputIsmRNA(input: String) -> Bool {
            for char in input.uppercaseString.characters {
                if (char != "A" && char != "U" && char != "C" && char != "G") {
                    return false
                }
            }
            return true
        }
        
        return (checkIfInputIsmRNA(input) && isValidLength(input)) ? false : true
    }
    
    // English is valid by default
	
	func stringIsNotEmpty(input: String) -> Bool {
		return input.characters.count == 0 ? true : false
	}
    
}
