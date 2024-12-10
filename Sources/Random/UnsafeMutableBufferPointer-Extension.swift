//
//  UnsafeMutableBufferPointer-Extension.swift
//  Random
//
//  Created by Giacomo Leopizzi on 10/12/24.
//

extension UnsafeMutableBufferPointer where Element == UInt8 {
    
    /// Fills the buffer with cryptographically secure random bytes.
    /// - Returns: `true` if the operation succeeded, `false` otherwise.
    @discardableResult
    public func fillWithSecureRandomBytes() -> Bool {
        // Ensure the base address exists
        guard let baseAddress else {
            return false
        }
        
        // Write secure random bytes to the buffer
        baseAddress.writeSecureRandomBytes(count: self.count)
        return true
    }
}
