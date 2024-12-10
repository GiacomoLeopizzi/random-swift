//
//  ArrayTests.swift
//  Random
//
//  Created by Giacomo Leopizzi on 10/12/24.
//

import Testing
import Foundation
@testable import Random

@Suite
struct ArrayTests {
    
    @Test
    func notAllZero() {
        let array = Array<UInt8>(withSecureRandom: 10)
        
        let isAllZero = array.allSatisfy({ $0 == .zero })
        #expect(!isAllZero, "Array should not be all zeros.")
    }
    
    @Test
    func notIdentical() {
        let array1 = Array<UInt8>(withSecureRandom: 10)
        let array2 = Array<UInt8>(withSecureRandom: 10)
        
        #expect(array1 != array2, "Consecutive random arrays should not be identical.")
    }

    @Test
    func containsVariety() {
        let array = Array<UInt8>(withSecureRandom: 100)
        
        // Check if the array contains a variety of values.
        let uniqueValues = Set(array)
        #expect(uniqueValues.count > 1, "Array should contain a variety of unique values.")
    }
    
    @Test
    func distribution() {
        let array = Array<UInt8>(withSecureRandom: 10_000)
        
        // Count occurrences of each value (0-255).
        var counts = [UInt8: Int](minimumCapacity: 256)
        array.forEach { counts[$0, default: 0] += 1 }
        
        // Ensure all 256 possible values are present.
        #expect(counts.keys.count == 256, "Array should contain all 256 possible values.")

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
        #expect(chiSquared <= criticalValue, "Value distribution fails chi-squared test (statistic: \(chiSquared)).")
    }

}

