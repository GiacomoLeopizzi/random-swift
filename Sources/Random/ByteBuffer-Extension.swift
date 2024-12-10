//
//  ByteBuffer-Extension.swift
//  Random
//
//  Created by Giacomo Leopizzi on 10/12/24.
//

import struct NIO.ByteBuffer

extension ByteBuffer {
    
    /// Writes cryptographically secure random bytes into the `ByteBuffer`.
    /// - Parameter count: The number of secure random bytes to generate and write into the buffer.
    public mutating func writeSecureRandomBytes(count: Int) {
        self.writeWithUnsafeMutableBytes(minimumWritableBytes: count) { buffer in
            guard let pointer = buffer.baseAddress else {
                return 0
            }
            pointer.writeSecureRandomBytes(count: count)
            return count
        }
    }
}
