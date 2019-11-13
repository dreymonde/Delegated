# Delegated
[![Swift][swift-badge]][swift-url]
[![Platform][platform-badge]][platform-url]

**Delegated** is a super small package that solves the retain cycle problem when dealing with closure-based delegation.

Medium post [here](https://medium.com/anysuggestion/preventing-memory-leaks-with-swift-compile-time-safety-49b845df4dc6).

## Usage

### Before:

```swift
self.downloader = ImageDownloader()
downloader.didDownload = { [weak self] image in
    guard let strongSelf = self else {
        return
    }
    strongSelf.currentImage = image
}
```

### After:

```swift
self.downloader = ImageDownloader()
downloader.didDownload.delegate(to: self) { (self, image) in
    self.currentImage = image
}
```

No retain cycles! No memory leaks! No `[weak self]`! 🎉

## Guide

### Creating a delegated function

```swift
class NumberPrinter {
    var numberToString = Delegated<Int, String>()
}
```

### Registering as a delegate

```swift
// somewhere inside init() or viewDidLoad() or similar
self.printer = NumberPrinter()
printer.numberToString.delegate(to: self) { (self, number) -> String in
    return self.convert(number: number)
}
```

By default, `delegate(to:with:)` will wrap `self` in a weak reference so that you don't need to remember to write `[weak self]` every time. This is the main feature of **Delegated**, but if this is not the behavior you want, you can use `stronglyDelegated(to:with:)` or `manuallyDelegated(with:)`:

```swift
self.printer = NumberPrinter()
printer.numberToString.stronglyDelegate(to: self) { (self, number) -> String in
    // will hold a strong reference to  `self`
    return self.convert(number: number) 
}
```

```swift
let printer = NumberPrinter()
printer.numberToString.manuallyDelegate(with: { number in
    return String(number)
})
```

### Calling a delegate

```swift
class NumberPrinter {
    
    var numberToString = Delegated<Int, String>()
    
    func printNumber(_ number: Int) {
        // .call returns nil if no delegate was set
        guard let string = numberToString.call(number) else {
            return
        }
        print(string)
    }
    
}
```

### Removing a delegate

```swift
var numberToString = Delegated<Int, String>()
// ...
numberToString.removeDelegate()
```

### Checking if delegate is set

```swift
var numberToString = Delegated<Int, String>()
// ...
numberToString.isDelegateSet // Bool
```

## Installation

#### Swift Package Manager

Starting with Xcode 11, **Delegated** is officially available *only* via Swift Package Manager.

In Xcode 11 or grater, in you project, select: `File > Swift Packages > Add Pacakage Dependency`

In the search bar type

```
https://github.com/dreymonde/Delegated
``` 

and when you find the package, with the **next** button you can proceed with the installation.

If you can't find anything in the panel of the Swift Packages you probably haven't added yet your github account.
You can do that under the **Preferences** panel of your Xcode, in the **Accounts** section.

For command-line based apps, you can just add this directly to your **Package.swift** file:

```swift
dependencies: [
    .package(url: "https://github.com/dreymonde/Delegated", from: "0.1.2"),
]
```

#### Manual

Of course, you always have an option of just copying-and-pasting the code - **Delegated** is just one file, so feel free.

#### Deprecated dependency managers

Last **Delegated** version to support [Carthage][carthage-url] and [Cocoapods][cocoapods-url] is **0.1.1**. Carthage and Cocoapods will no longer be officially supported.

Carthage:

```ruby
github "dreymonde/Delegated" ~> 0.1.1
```

Cocoapods:

```ruby
pod 'Delegated', '~> 0.1.1'
```

## See also

- [krzysztofzablocki/Strongify](https://github.com/krzysztofzablocki/Strongify) - a 1-file µframework providing a nicer API for avoiding weak-strong dance.

[swift-badge]: https://img.shields.io/badge/Swift-5.1-orange.svg?style=flat
[swift-url]: https://swift.org
[platform-badge]: https://img.shields.io/badge/platform-iOS%20%7C%20macOS%20%7C%20watchOS%20%7C%20tvOS%20%7C%20Linux-lightgrey.svg
[platform-url]: https://developer.apple.com/swift/
[carthage-url]: https://github.com/Carthage/Carthage
[cocoapods-url]: https://github.com/CocoaPods/CocoaPods
