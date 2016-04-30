//
//  BioKodeTests.swift
//  BioKodeTests
//
//  Created by Peter Kos on 4/19/16.
//  Copyright © 2016 Peter Kos. All rights reserved.
//

import XCTest
@testable import BioKode

class BioKodeTests: XCTestCase {
	
	let bioTrans = BioTranslate()
	
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
	
	func testDNAtomRNA() {
		let givenInput     = ["AAC", "AGC", "TGA", "TGC", "TCG", "CGT", "GCC", "CGA", "GCT", "GAC"]
		let expectedOutput = ["UUG", "UCG", "ACU", "ACG", "AGC", "GCA", "CGG", "GCU", "CGA", "CUG"]
		var actualOutput   = [String]()
		
		// Calculate sequences
		for sequence in givenInput {
			actualOutput.append(bioTrans.fromDNAtomRNA(sequence))
		}
		
		// Verify sequences
		XCTAssertEqual(expectedOutput, actualOutput)
	}
	
	func testmRNAtoDNA() {
		let givenInput     = ["UGA", "UCG", "AGG", "AGC", "GAC", "GAA", "GAU", "CGC", "CGU", "CAG"]
		let expectedOutput = ["ACT", "AGC", "TCC", "TCG", "CTG", "CTT", "CTA", "GCG", "GCA", "GTC"]
		var actualOutput   = [String]()
		
		// Calculate sequences
		for sequence in givenInput {
			actualOutput.append(bioTrans.frommRNAtoDNA(sequence))
		}
		
		// Verify sequences
		XCTAssertEqual(expectedOutput, actualOutput)
	}
	
	func testDNAtoEnglish() {
		let givenInput     = "GATAAAGTCGTGTACTTTGTGGTCTCGACG"
		let expectedOutput = "NAILPOLISH"
		let actualOutput   = bioTrans.fromDNAtoEnglish(givenInput)
		
		// Verify sequences
		XCTAssertEqual(expectedOutput, actualOutput)
	}
	
	func testmRNAtoEnglish() {
		let givenInput     = "UAUAAAAAAGGGCAAAAU"
		let expectedOutput = "COOKIE"
		let actualOutput   = bioTrans.frommRNAtoEnglish(givenInput)
		
		// Verify sequences
		XCTAssertEqual(expectedOutput, actualOutput)
	}
	
	// FIX test to accomodate for polygenetic selection
	func testEnglishtomRNA() {
		let givenInput     = "THEQUICKBROWNFOXJUMPEDOVERTHELAZYDOG"
		let expectedOutput = ("ACA UGU AAU UUA GCU CAA UAU GGU GCA CCU AAA UGG CUU GAU AAA AUA GAA GCU AUU AUG AAU AGA AAA ACU AAU CCU ACA UGU AAU CAU UUU GUU GUA AGA AAA UAA").stringByReplacingOccurrencesOfString(" ", withString: "")
		let actualOutput   = bioTrans.fromEnglishtomRNA(givenInput)
		let polyGen = NSUserDefaults.standardUserDefaults().valueForKey("polygeneticSelection")
		
		// Explicitly sets polygenetic selection to false
		NSUserDefaults.standardUserDefaults().setValue(1, forKey: "polygeneticSelection")
		print(expectedOutput)
		print(actualOutput)
		XCTAssertEqual(expectedOutput, actualOutput)
		
		// Resets polygenetic selection to user defaults
		NSUserDefaults.standardUserDefaults().setValue(polyGen, forKey: "polygeneticSelection")
	}
	
	func testEnglishtomDNA() {
		let givenInput     = "GROUPSELFIEWITHATEACHER"
		let expectedOutput = ("ATTGGGTTTCGATACTCGTTGGTGCTGGTTTTGACCGTTTGTACAAAATGCTTAAAAATGACGTTAGGG").stringByReplacingOccurrencesOfString(" ", withString: "")
		let actualOutput   = bioTrans.fromEnglishtoDNA(givenInput)
		let polyGen = NSUserDefaults.standardUserDefaults().valueForKey("polygeneticSelection")
		
		// Explicitly sets polygenetic selection to false
		NSUserDefaults.standardUserDefaults().setValue(1, forKey: "polygeneticSelection")
		print(expectedOutput)
		print(actualOutput)
		XCTAssertEqual(expectedOutput, actualOutput)
		
		// Resets polygenetic selection to user defaults
		NSUserDefaults.standardUserDefaults().setValue(polyGen, forKey: "polygeneticSelection")
	}
	

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
