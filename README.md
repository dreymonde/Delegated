# Delegated 2.0

**Delegated** is a super small package that helps you avoid retain cycles when using closure-based delegation.

New Medium post [here](https://medium.com/anysuggestion/no-more-weak-self-or-the-weird-new-future-of-delegation-f2a2745cd73).

Original Medium post (Delegated 0.1.2) [here](https://medium.com/anysuggestion/preventing-memory-leaks-with-swift-compile-time-safety-49b845df4dc6).

> 🚨 WARNING!  **Delegated 2.0** is not compatible with **Delegated 0.1.2**. If you don't want to migrate your current codebase, stay on Delegated 0.1.2. See documentation for Delegated 0.1.2 [here](https://github.com/dreymonde/Delegated/tree/0.1.2). If you need any help migrating from 0.1.x to 2.0.x, please open an issue.

## Usage

### Before:

```swift
final class TextField {
    var didUpdate: (String) -> () = { _ in }
}

// later...

self.textField.didUpdate = { [weak self] text in
    guard let strongSelf = self else {
        return
    }
    strongSelf.label.text = text
}
```

### After:

```swift
final class TextField {
    @Delegated var didUpdate: (String) -> ()
}

// later...

textField.$didUpdate.delegate(to: self) { (self, text) in
    // `self` is weak automatically!
    self.label.text = text
}
```


No retain cycles! No memory leaks! No `[weak self]`! 🎉

## Guide

### Creating a delegated function

```swift
final class TextField {
    @Delegated var didUpdate: (String) -> ()
}
```

This will only compile for closures that have **exactly one** argument and no return value. To use any other number of arguments, use this:

```swift
final class TextField {
    @Delegated0 var didStartEditing: () -> Void
    @Delegated1 var didUpdate: (String) -> Void
    @Delegated2 var didReplace: (String, String) -> Void
}
```

`Delegated0` - `Delegated4` are provided out of the box. `Delegated` is a typealias for `Delegated1`.

### Registering as a delegate

```swift
// somewhere inside init() or viewDidLoad() or similar
self.textField = TextField()
textField.$didUpdate.delegate(to: self) { (self, text) in
    self.label.text = text
}
```

By default, `delegate(to:with:)` will wrap `self` in a weak reference so that you don't need to remember to write `[weak self]` every time. This is the main feature of **Delegated**, but if this is not the behavior you want, you can use `manuallyDelegate(with:)`:

```swift
// somewhere inside init() or viewDidLoad() or similar
self.textField = TextField()
textField.$didUpdate.manuallyDelegate { (text) in
    print(text)
}
```

### Calling a delegate

```swift
final class TextField {
    @Delegated var didUpdate: (String) -> Void
    
    /// ...
    
    private func didFinishEditing() {
        self.didUpdate(self.text)
    }
}
```

### Delegating a function with a return value

If your delegated function is designed to have a return value (non-Void), use `@ReturningDelegated` wrapper.

```swift
final class TextField {
    @ReturningDelegated  var shouldReturn: (String) -> Bool?
    
    @ReturningDelegated0 var shouldBeginEditing: () -> Bool?
    @ReturningDelegated2 var shouldReplace: (String, String) -> Bool?
}

// ...

textField.$shouldReturn.delegate(to: self) { (self, string) -> Bool in
    if string.count > 5 {
        return true
    } else {
        return false
    }
}
```

**IMPORTANT**: Make sure that your `@ReturningDelegated` function returns **an optional**. It will return `nil` if no delegate is set.

Default `@ReturningDelegated` supports exactly one input argument. Use `@ReturningDelegated0` - `@ReturningDelegated4` if you need a different number of arguments (see above).

### Removing a delegate

```swift
@Delegated var didUpdate: (String) -> ()
// ...
self.$didUpdate.removeDelegate()
```

## Installation

#### Swift Package Manager

**Delegated** is officially available *only* via Swift Package Manager.

In Xcode 11 or greater, in you project, select: `File > Swift Packages > Add Pacakage Dependency`

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
    .package(url: "https://github.com/dreymonde/Delegated", from: "2.1.0"),
]
```

#### Manual

Of course, you always have an option of just copying-and-pasting the code - **Delegated** is just one file, so feel free.
