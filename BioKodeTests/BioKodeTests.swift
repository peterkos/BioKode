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
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
