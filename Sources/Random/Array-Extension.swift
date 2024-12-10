//
//  Array-Extension.swift
//  Random
//
//  Created by Giacomo Leopizzi on 10/12/24.
//

extension Array where Element : FixedWidthInteger, Element : UnsignedInteger{
    
    /// Creates an array filled with cryptographically secure random bytes.
    ///
    /// This initializer generates an array of the specified size, where each element is a secure random byte.
    ///
    /// - Parameter elementsCount: The number of secure random elements to generate and initialize in the array.
    public init(withSecureRandom elementsCount: Int) {
        self.init(unsafeUninitializedCapacity: elementsCount) { buffer, initializedCount in
            let rawBuffer = UnsafeMutableRawBufferPointer(buffer)
            let success = rawBuffer.fillWithSecureRandomBytes()
            precondition(success)
            
            initializedCount = rawBuffer.count
        }
    }
}
