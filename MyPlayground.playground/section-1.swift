// Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"



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
    for _ in 1...numStrings {
        let rand = Int(arc4random_uniform( UInt32 (maxLength)))
        let result = randomStringWithLength(rand)
        results.append(result)
    }
    return results
}


let a = randomStrings(20, 20)

var f = BloomFilter(capacity: 200, errorRate: 0.01)


