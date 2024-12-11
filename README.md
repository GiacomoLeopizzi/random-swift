# Random

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FGiacomoLeopizzi%2Frandom-swift%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/GiacomoLeopizzi/random-swift)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FGiacomoLeopizzi%2Frandom-swift%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/GiacomoLeopizzi/random-swift)

A Swift package for generating cryptographically secure random bytes and numbers. Built using `swift-nio` and `swift-nio-ssl`.

## Features

- Secure random number generation suitable for cryptographic applications.
- Utilities to generate secure random bytes and fill buffers with random data.
- Extensions to integrate with common Swift and NIO types.

## Installation

Add the `Random` package to your `Package.swift`:

```swift
// swift-tools-version:6.0
import PackageDescription

let package = Package(
    name: "YourProject",
    dependencies: [
        .package(url: "https://github.com/GiacomoLeopizzi/random-swift", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "YourTarget",
            dependencies: [
                .product(name: "Random", package: "random-swift")
            ]
        ),
    ]
)
```

## Usage

### 1. Generating Secure Random Numbers

Use `SecureRandomNumberGenerator` to generate cryptographically secure random numbers:

```swift
import Random

var generator = SecureRandomNumberGenerator()
let randomValue = generator.next() // Generates a secure random UInt64
```

### 2. Creating an Array of Secure Random Bytes

Generate an array filled with secure random bytes:

```swift
import Random

let randomBytes = [UInt8](withSecureRandom: 16) // An array of 16 secure random bytes
```

### 3. Writing Secure Random Bytes to a `ByteBuffer`

```swift
import Random
import NIO

var buffer = ByteBuffer()
buffer.writeSecureRandomBytes(count: 32) // Writes 32 secure random bytes into the buffer
```

### 4. Filling Buffers with Secure Random Bytes

#### Using `UnsafeMutableRawBufferPointer`

```swift
import Random

var rawBuffer = UnsafeMutableRawBufferPointer.allocate(byteCount: 16, alignment: 1)

defer {
    rawBuffer.deallocate()
}

let success = rawBuffer.fillWithSecureRandomBytes()
assert(success, "Failed to fill buffer with secure random bytes")
```

#### Using `UnsafeMutableBufferPointer`

```swift
import Random

var buffer = UnsafeMutableBufferPointer<UInt8>.allocate(capacity: 16)

defer {
    buffer.deallocate()
}

let success = buffer.fillWithSecureRandomBytes()
assert(success, "Failed to fill buffer with secure random bytes")
```

### 5. Extending Pointers

#### `UnsafeMutablePointer`

Write secure random bytes to the memory pointed to by a pointer:

```swift
import Random

let pointer = UnsafeMutablePointer<UInt8>.allocate(capacity: 16)

defer {
    pointer.deallocate()
}

pointer.writeSecureRandomBytes(count: 16)
```

#### `UnsafeMutableRawPointer`

```swift
import Random

let rawPointer = UnsafeMutableRawPointer.allocate(byteCount: 16, alignment: 1)

defer {
    rawPointer.deallocate()
}

rawPointer.writeSecureRandomBytes(count: 16)
```

### 6. Using `SecureRandomNumberGenerator` with Collections

`SecureRandomNumberGenerator` conforms to the `RandomNumberGenerator` protocol, meaning it can be used to generate secure random values for standard Swift collection APIs like `randomElement(using:)`.

#### Example: Picking a Random Character from a String

```swift
import Random

let alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
var generator = SecureRandomNumberGenerator()

if let char = alphabet.randomElement(using: &generator) {
    print("Random character: \(char)")
}
```

#### Example: Shuffling an Array Securely

```swift
import Random

var numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
var generator = SecureRandomNumberGenerator()

numbers.shuffle(using: &generator)

print("Shuffled array: \(numbers)")
```

#### Example: Generating a Secure Random Password

```swift
import Random

let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()"
var generator = SecureRandomNumberGenerator()

let passwordLength = 16
let password = String((0..<passwordLength).compactMap { _ in characters.randomElement(using: &generator) })

print("Secure random password: \(password)")
```

## API Reference

### `SecureRandomNumberGenerator`

A cryptographically secure random number generator. Conforms to the `RandomNumberGenerator` protocol.

- **`next() -> UInt64`**: Generates a secure random `UInt64`.

### Extensions

#### Array

- **`init(withSecureRandom elementsCount: Int)`**: Initializes an array with cryptographically secure random bytes.

#### ByteBuffer

- **`writeSecureRandomBytes(count: Int)`**: Writes secure random bytes into the `ByteBuffer`.

#### UnsafeMutableBufferPointer

- **`fillWithSecureRandomBytes() -> Bool`**: Fills the buffer with secure random bytes.

#### UnsafeMutableRawBufferPointer

- **`fillWithSecureRandomBytes() -> Bool`**: Fills the raw buffer with secure random bytes.

#### UnsafeMutablePointer

- **`writeSecureRandomBytes(count: Int)`**: Writes secure random bytes to the memory pointed to by the pointer.

#### UnsafeMutableRawPointer

- **`writeSecureRandomBytes(count: Int)`**: Writes secure random bytes to the raw pointer memory.

## Contributing

Contributions are welcome! Feel free to submit a pull request or open an issue for any improvements or bug fixes.
