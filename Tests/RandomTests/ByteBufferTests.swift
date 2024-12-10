//
//  ByteBufferTests.swift
//  Random
//
//  Created by Giacomo Leopizzi on 10/12/24.
//

import Testing
import Foundation
import NIO
@testable import Random

@Suite
struct ByteBufferTests {
    
    @Test
    func notAllZero() {
        var byteBuffer = ByteBuffer()
        try? byteBuffer.writeSecureRandomBytes(count: 10)
        
        let array = byteBuffer.readBytes(length: 10) ?? []
        let isAllZero = array.allSatisfy({ $0 == .zero })
        #expect(!isAllZero, "ByteBuffer should not contain all zeros.")
    }
    
    @Test
    func notIdentical() {
        var byteBuffer1 = ByteBuffer()
        var byteBuffer2 = ByteBuffer()
        try? byteBuffer1.writeSecureRandomBytes(count: 10)
        try? byteBuffer2.writeSecureRandomBytes(count: 10)
        
        let array1 = byteBuffer1.readBytes(length: 10) ?? []
        let array2 = byteBuffer2.readBytes(length: 10) ?? []
        #expect(array1 != array2, "Consecutive ByteBuffer random contents should not be identical.")
    }
    
    @Test
    func containsVariety() {
        var byteBuffer = ByteBuffer()
        try? byteBuffer.writeSecureRandomBytes(count: 100)
        
        let array = byteBuffer.readBytes(length: 100) ?? []
        let uniqueValues = Set(array)
        #expect(uniqueValues.count > 1, "ByteBuffer should contain a variety of unique values.")
    }
    
    @Test
    func distribution() {
        var byteBuffer = ByteBuffer()
        try? byteBuffer.writeSecureRandomBytes(count: 10_000)
        
        let array = byteBuffer.readBytes(length: 10_000) ?? []
        
        // Count occurrences of each value (0-255).
        var counts = [UInt8: Int](minimumCapacity: 256)
        array.forEach { counts[$0, default: 0] += 1 }
        
        // Ensure all 256 possible values are present.
        #expect(counts.keys.count == 256, "ByteBuffer should contain all 256 possible values.")

        // Calculate expected frequency for a uniform distribution.
        let expectedFrequency = array.count / 256
        
        // Perform chi-squared test.
        var chiSquared: Double = 0
        for value in 0..<256 {
            let observed = Double(counts[UInt8(value)] ?? 0)
            let expected = Double(expectedFrequency)
            chiSquared += pow(observed - expected, 2) / expected
        }
        
        // Critical value for chi-squared at 0.05 significance level (for 255 degrees of freedom)
        let criticalValue = 293.24
        
        // Verify the chi-squared statistic does not exceed the critical value.
        #expect(chiSquared <= criticalValue, "ByteBuffer value distribution fails chi-squared test (statistic: \(chiSquared)).")
    }
}
