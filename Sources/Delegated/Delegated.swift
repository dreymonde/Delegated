//
//  Delegated.swift
//  Delegated
//
//  Created by Oleg Dreyman on 3/11/18.
//  Copyright © 2018 Delegated. All rights reserved.
//


public struct Delegated<Input, Output> {
    
    private(set) var callback: ((Input) -> Output?)?
    
    public init() { }
    
    public mutating func delegate<Target : AnyObject>(to target: Target,
                                                      with callback: @escaping (Target, Input) -> Output) {
        self.callback = { [weak target] input in
            guard let target = target else {
                return nil
            }
            return callback(target, input)
        }
    }
    
    public func call(_ input: Input) -> Output? {
        return self.callback?(input)
    }
    
    public var isDelegateSet: Bool {
        return callback != nil
    }
    
}

extension Delegated {
    
    public mutating func stronglyDelegate<Target : AnyObject>(to target: Target,
                                                              with callback: @escaping (Target, Input) -> Output) {
        self.callback = { input in
            return callback(target, input)
        }
    }
    
    public mutating func manuallyDelegate(with callback: @escaping (Input) -> Output) {
        self.callback = callback
    }
    
    public mutating func removeDelegate() {
        self.callback = nil
    }
    
}

extension Delegated where Input == Void {
    
    public mutating func delegate<Target : AnyObject>(to target: Target,
                                                      with callback: @escaping (Target) -> Output) {
        self.delegate(to: target, with: { target, voidInput in callback(target) })
    }
    
    public mutating func stronglyDelegate<Target : AnyObject>(to target: Target,
                                                              with callback: @escaping (Target) -> Output) {
        self.stronglyDelegate(to: target, with: { target, voidInput in callback(target) })
    }
    
}

extension Delegated where Input == Void {
    
    public func call() -> Output? {
        return self.call(())
    }
    
}

extension Delegated where Output == Void {
    
    public func call(_ input: Input) {
        self.callback?(input)
    }
    
}

extension Delegated where Input == Void, Output == Void {
    
    public func call() {
        self.call(())
    }
    
}

