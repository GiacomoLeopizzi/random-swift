//
//  UnsafeMutablePointer-Extension.swift
//  Random
//
//  Created by Giacomo Leopizzi on 10/12/24.
//

import CNIOBoringSSL

extension UnsafeMutablePointer where Pointee == UInt8 {
    
    /// Writes cryptographically secure random bytes to the memory pointed to by this pointer.
    ///
    /// This method uses `CNIOBoringSSL_RAND_bytes` to generate random bytes suitable for
    /// cryptographic purposes and directly writes them to the memory.
    ///
    /// - Parameter count: The number of random bytes to generate and write.
    public func writeSecureRandomBytes(count: Int) {
        CNIOBoringSSL_RAND_bytes(self, count)
    }
}
