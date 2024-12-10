//
//  SecureRandomNumberGeneratorTests.swift
//  Random
//
//  Created by Giacomo Leopizzi on 10/12/24.
//

import Testing
import Foundation
@testable import Random

@Suite
struct SecureRandomNumberGeneratorTests {
    
    @Test
    func notIdentical() throws {
        let alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        var generator = SecureRandomNumberGenerator()
        
        let char1 = try #require(alphabet.randomElement(using: &generator))
        let char2 = try #require(alphabet.randomElement(using: &generator))
        #expect(char1 != char2, "Consecutive random characters should not be identical.")
        
        let int1 = Int8.random(in: Int8.min...Int8.max, using: &generator)
        let int2 = Int8.random(in: Int8.min...Int8.max, using: &generator)
        #expect(int1 != int2, "Consecutive random integers should not be identical.")
    }
    
    @Test
    func distributionOfBytes() {
        var generator = SecureRandomNumberGenerator()
        var byteCounts = [UInt8: Int](minimumCapacity: 256)
        
        for _ in 0..<10_000 {
            let randomValue = generator.next()
            
            // Break down UInt64 into individual bytes and count occurrences
            withUnsafeBytes(of: randomValue) { bytes in
                for byte in bytes {
                    byteCounts[byte, default: 0] += 1
                }
            }
        }
        
        // Ensure all 256 byte values are present.
        #expect(byteCounts.keys.count == 256, "All 256 byte values should be generated.")

        // Perform chi-squared test to validate distribution.
        let totalBytes = 10_000 * 8 // 8 bytes per UInt64
        let expectedFrequency = totalBytes / 256
        var chiSquared: Double = 0
        
        for value in 0..<256 {
            let observed = Double(byteCounts[UInt8(value)] ?? 0)
            let expected = Double(expectedFrequency)
            chiSquared += pow(observed - expected, 2) / expected
        }
        
        // Critical value for chi-squared at 0.05 significance level (for 255 degrees of freedom)
        let criticalValue = 293.24
        
        #expect(chiSquared <= criticalValue, "Byte value distribution fails chi-squared test (statistic: \(chiSquared)).")
    }
}
