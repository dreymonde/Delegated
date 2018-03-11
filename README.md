# Delegated

**Delegated** is a super small package that solves the retain cycle problem when dealing with closure-based delegation.

Medium post here.

## Usage

### Before:

```swift
self.downloader = ImageDownloader()
downloader.didDownload = { [weak self] image in
    self?.currentImage = image
}
```

### After:

```swift
self.downloader = ImageDownloader()
downloader.didDownload.delegate(to: self) { (self, image) in
    self.image = image
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

**AppFolder** is available through [Carthage][carthage-url]. To install, just write into your Cartfile:

```ruby
github "dreymonde/Delegated" ~> 0.1.0
```

**AppFolder** is also available through [Cocoapods][cocoapods-url]:

```ruby
pod 'Delegated', '~> 0.1.0'
```

And Swift Package Manager:

```swift
dependencies: [
    .Package(url: "https://github.com/dreymonde/Delegated.git", majorVersion: 0, minor: 1),
]
```

[carthage-url]: https://github.com/Carthage/Carthage
[cocoapods-url]: https://github.com/CocoaPods/CocoaPods
