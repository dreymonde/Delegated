//
//  Delegated_5.9.swift
//  Delegated
//
//  Created by Oleg on 4/18/25.
//

#if swift(>=5.9)
@available(watchOS 10.0.0, *)
@available(tvOS 17.0.0, *)
@available(iOS 17.0.0, *)
@available(macOS 14.0.0, *)
@propertyWrapper
public final class Delegated<each Input> {
    private var callback: (repeat each Input) -> Void
    
    public init() {
        self.callback = { (_: repeat each Input) -> Void in
            return
        }
    }
    
    public var wrappedValue: (repeat each Input) -> Void {
        callback
    }
    
    public var projectedValue: Delegated<repeat each Input> {
        self
    }
}

@available(watchOS 10.0.0, *)
@available(tvOS 17.0.0, *)
@available(iOS 17.0.0, *)
@available(macOS 14.0.0, *)
public extension Delegated {
    func delegate<Target: AnyObject>(
        to target: Target,
        with callback: @escaping (Target, repeat each Input) -> Void
    ) {
        self.callback = { [weak target] (input: repeat each Input) -> Void in
            guard let target = target else {
                return
            }
            return callback(target, repeat each input)
        }
    }
    
    func manuallyDelegate(with callback: @escaping (repeat each Input) -> Void) {
        self.callback = callback
    }
    
    func removeDelegate() {
        self.callback = { (_: repeat each Input) -> Void in
            return
        }
    }
}

@available(watchOS 10.0.0, *)
@available(tvOS 17.0.0, *)
@available(iOS 17.0.0, *)
@available(macOS 14.0.0, *)
public extension Delegated {
    func pipe<Target: AnyObject>(
        via target: Target,
        to delegation: KeyPath<Target, Delegated<repeat each Input>>
    ) {
        self.delegate(to: target) { (target, input: repeat each Input) in
            target[keyPath: delegation].wrappedValue(repeat each input)
        }
    }
    
    func pipe<Target: AnyObject, each OtherInput>(
        via target: Target,
        to delegation: KeyPath<Target, Delegated<repeat each OtherInput>>,
        transform: @escaping (Target, repeat each Input) -> (repeat each OtherInput)
    ) {
        self.delegate(to: target) { (target, input: repeat each Input) in
            let output = transform(target, repeat each input)
            target[keyPath: delegation].wrappedValue(repeat each output)
        }
    }
}

@available(watchOS 10.0.0, *)
@available(tvOS 17.0.0, *)
@available(iOS 17.0.0, *)
@available(macOS 14.0.0, *)
@propertyWrapper
public final class ReturningDelegated<each Input, Output> {
    
    private var callback: (repeat each Input) -> Output?
    
    public init() {
        self.callback = { (_: repeat each Input) -> Output? in return nil }
    }
    
    public var wrappedValue: (repeat each Input) -> Output? {
        return callback
    }
    
    public var projectedValue: ReturningDelegated<repeat each Input, Output> {
        return self
    }
}

@available(watchOS 10.0.0, *)
@available(tvOS 17.0.0, *)
@available(iOS 17.0.0, *)
@available(macOS 14.0.0, *)
public extension ReturningDelegated {
    func delegate<Target: AnyObject>(
        to target: Target,
        with callback: @escaping (Target, repeat each Input) -> Output?
    ) {
        self.callback = { [weak target] (input: repeat each Input) -> Output? in
            guard let target = target else {
                return nil
            }
            return callback(target, repeat each input)
        }
    }
    
    func manuallyDelegate(with callback: @escaping (repeat each Input) -> Output?) {
        self.callback = callback
    }

    func removeDelegate() {
        self.callback = { (_: repeat each Input) -> Output? in return nil }
    }
}

@available(watchOS 10.0.0, *)
@available(tvOS 17.0.0, *)
@available(iOS 17.0.0, *)
@available(macOS 14.0.0, *)
public extension ReturningDelegated {
    func pipe<Target: AnyObject>(
        via target: Target,
        through delegation: KeyPath<Target, ReturningDelegated<repeat each Input, Output>>
    ) {
        self.delegate(to: target) { (target, input: repeat each Input) in
            target[keyPath: delegation].wrappedValue(repeat each input)
        }
    }
    
    func pipe<Target: AnyObject, each OtherInput>(
        via target: Target,
        through delegation: KeyPath<Target, ReturningDelegated<repeat each OtherInput, Output>>,
        transform: @escaping (Target, repeat each Input) -> (repeat each OtherInput)
    ) {
        self.delegate(to: target) { (target, input: repeat each Input) in
            let output = transform(target, repeat each input)
            return target[keyPath: delegation].wrappedValue(repeat each output)
        }
    }
}
#else
public typealias Delegated = Delegated1
public typealias ReturningDelegated = ReturningDelegated1
#endif
