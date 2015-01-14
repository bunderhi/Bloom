//
//  BloomFilter.swift
//  bloom
//
//  Created by Brian Underhill on 2015-01-14.
//  Copyright (c) 2015 Brian Underhill. All rights reserved.
//

import Foundation

class BloomFilter {
    
    let m: Int
    let k: Int
    let capacity: Int
    var count: Int
    private var b: [Bool]
    
    init(capacity: Int, errorRate: Float) {
        let mFloat = ceil((Float(capacity) * log(errorRate)) / log(1.0 / (pow(2.0, log(2.0)))))
        k = Int(round(log(2.0) * mFloat / Float(capacity)))
        m = Int(mFloat)
        count = 0
        self.capacity = capacity
        b = [Bool](count: m, repeatedValue: false)
    }
    
    func truthiness() -> Double {
        var trueBits  = 0
        for i in b {
            if i  { ++trueBits }
        }
        return Double(trueBits) / Double(m)
    }
    
    func probError() -> Double {
        return pow(truthiness(),Double(k))
    }
    
    
    private func hashFNV_1a(data: [UInt8]) -> UInt32 {
        var lower8:UInt32
        let mask:UInt32 = 255
        var x:UInt32 =  2_166_136_261
        for byte in data {
            lower8 = (mask & x) ^ UInt32(byte) //XOR with lower 8 bits of x
            x = x >> 8 //clear the lower 8 bits
            x = x << 8 //shift the upper bits back into their original position
            x = x | lower8 //incorporate XOR result into x
            x = 16_777_619 &* x //Prime multiplication step of FNV algorithm
        }
        return x
    }
    
    private func getHash(data: String, index: Int) -> Int {
        let buf = [UInt8](data.utf8)
        let hval = hashFNV_1a(buf)
        return abs((Int(hval)*index) % m)
    }
    
    
    
    func setValue(data: String) {
        for i in 1...k {
            b[getHash(data,index: i)] = true
        }
        ++count
    }
    
    func contains(data: String) -> Bool {
        for i in 1...k {
            if !b[getHash(data,index: i)] {
                return false
            }
        }
        return true
    }
}