//
//  SecureRandomNumberGenerator.swift
//  Random
//
//  Created by Giacomo Leopizzi on 10/12/24.
//

/// A cryptographically secure random number generator.
///
/// This generator uses a secure random source to generate random numbers
/// suitable for cryptographic applications and ensures high-quality randomness.
public struct SecureRandomNumberGenerator: RandomNumberGenerator {
    
    public mutating func next() -> UInt64 {
        var output: UInt64 = 0
        withUnsafeMutableBytes(of: &output) { buffer in
            let success = buffer.fillWithSecureRandomBytes()
            precondition(success, "Failed to generate secure random bytes.")
        }
        return output
    }
}
