//
//  bloomTests.swift
//  bloomTests
//
//  Created by Brian Underhill on 2015-01-14.
//  Copyright (c) 2015 Brian Underhill. All rights reserved.
//

import Foundation
import XCTest
import bloom

class bloomTests: XCTestCase {
    
    func randomStringWithLength (len : Int) -> String {
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let length = UInt32 (letters.length)
        var randomString : NSMutableString = NSMutableString(capacity: len)
        for _ in 0...len {
            var rand = arc4random_uniform(length)
            randomString.appendFormat("%C", letters.characterAtIndex(Int(rand)))
        }
        return randomString as String
    }
    
    func randomStrings (numStrings : Int, maxLength : Int) -> [String] {
        var results : [String] = []
        for _ in 0...numStrings {
            let rand = Int(arc4random_uniform( UInt32 (maxLength)))
            let result = randomStringWithLength(rand)
            results.append(result)
        }
        return results
    }
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        
        var f = BloomFilter(capacity: 200, errorRate: 0.01)
        let a = randomStrings(20, maxLength: 20)
        for i in a {
            f.setValue(i)
        }
        f.setValue("sdfsdewr34")
        
        XCTAssert(f.contains("sdfsdewr34"), "Pass contains test")
        XCTAssertFalse(f.contains("werew"), "Pass not contaions test")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
