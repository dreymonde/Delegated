//
//  Delegated.swift
//  Delegated
//
//  Created by Oleg Dreyman on 12/7/2020.
//  Copyright © 2020 Oleg Dreyman. All rights reserved.
//

@propertyWrapper
public final class Delegated<C> {
    
    public var wrappedValue: C
    
    public var projectedValue: Delegated<C> {
        self
    }
    
    public init(wrappedValue: C) {
        self.wrappedValue = wrappedValue
    }
}

extension Delegated {
    public convenience init() where C == () -> Void {
        self.init(wrappedValue: {})
    }
    
    public convenience init<Input>() where C == (Input) -> Void {
        self.init(wrappedValue: { _ in })
    }
    
    public convenience init<Input1, Input2>() where C == (Input1, Input2) -> Void {
        self.init(wrappedValue: { _, _ in })
    }
    
    public convenience init<Input1, Input2, Input3>() where C == (Input1, Input2, Input3) -> Void {
        self.init(wrappedValue: { _, _, _ in })
    }
    
    public convenience init<Input1, Input2, Input3, Input4>() where C == (Input1, Input2, Input3, Input4) -> Void {
        self.init(wrappedValue: { _, _, _, _ in })
    }
}

extension Delegated {
    public convenience init<Output>() where C == () -> Output? {
        self.init(wrappedValue: { return nil })
    }
    
    public convenience init<Input, Output>() where C == (Input) -> Output? {
        self.init(wrappedValue: { _ in return nil })
    }
    
    public convenience init<Input1, Input2, Output>() where C == (Input1, Input2) -> Output? {
        self.init(wrappedValue: { _, _ in return nil })
    }
    
    public convenience init<Input1, Input2, Input3, Output>() where C == (Input1, Input2, Input3) -> Output? {
        self.init(wrappedValue: { _, _, _ in return nil })
    }
    
    public convenience init<Input1, Input2, Input3, Input4, Output>() where C == (Input1, Input2, Input3, Input4) -> Output? {
        self.init(wrappedValue: { _, _, _, _ in return nil })
    }
}

extension Delegated {
    public func delegate<Target: AnyObject>(to target: Target, _ handler: @escaping (Target) -> Void) where C == () -> Void {
        self.wrappedValue = { [weak target] in
            guard let target = target else { return }
            handler(target)
        }
    }
    
    public func delegate<Target: AnyObject,Input>(to target: Target, _ handler: @escaping (Target, Input) -> Void) where C == (Input) -> Void {
        self.wrappedValue = { [weak target] in
            guard let target = target else { return }
            handler(target, $0)
        }
    }
    
    public func delegate<Target: AnyObject, Input1, Input2>(to target: Target, _ handler: @escaping (Target, Input1, Input2) -> Void) where C == (Input1, Input2) -> Void {
        self.wrappedValue = { [weak target] in
            guard let target = target else { return }
            handler(target, $0, $1)
        }
    }
    
    public func delegate<Target: AnyObject, Input1, Input2, Input3>(to target: Target, _ handler: @escaping (Target, Input1, Input2, Input3) -> Void) where C == (Input1, Input2 ,Input3) -> Void {
        self.wrappedValue = { [weak target] in
            guard let target = target else { return }
            handler(target, $0, $1, $2)
        }
    }
    
    public func delegate<Target: AnyObject, Input1, Input2, Input3, Input4>(to target: Target, _ handler: @escaping (Target, Input1, Input2, Input3, Input4) -> Void) where C == (Input1, Input2, Input3, Input4) -> Void {
        self.wrappedValue = { [weak target] in
            guard let target = target else { return }
            handler(target, $0, $1, $2, $3)
        }
    }
}

extension Delegated {
    public func delegate<Target: AnyObject, Output>(to target: Target, _ handler: @escaping (Target) -> Output) where C == () -> Output? {
        self.wrappedValue = { [weak target] in
            guard let target = target else { return nil }
            return handler(target)
        }
    }
    
    public func delegate<Target: AnyObject, Input, Output>(to target: Target, _ handler: @escaping (Target, Input) -> Output) where C == (Input) -> Output? {
        self.wrappedValue = { [weak target] in
            guard let target = target else { return nil }
            return handler(target, $0)
        }
    }
    
    public func delegate<Target: AnyObject, Input1, Input2, Output>(to target: Target, _ handler: @escaping (Target, Input1, Input2) -> Output) where C == (Input1, Input2) -> Output? {
        self.wrappedValue = { [weak target] in
            guard let target = target else { return nil }
            return handler(target, $0, $1)
        }
    }
    
    public func delegate<Target: AnyObject, Input1, Input2, Input3, Output>(to target: Target, _ handler: @escaping (Target, Input1, Input2, Input3) -> Output) where C == (Input1, Input2, Input3) -> Output? {
        self.wrappedValue = { [weak target] in
            guard let target = target else { return nil }
            return handler(target, $0, $1, $2)
        }
    }
    
    public func delegate<Target: AnyObject, Input1, Input2, Input3, Input4, Output>(to target: Target, _ handler: @escaping (Target, Input1, Input2, Input3, Input4) -> Output) where C == (Input1, Input2, Input3, Input4) -> Output? {
        self.wrappedValue = { [weak target] in
            guard let target = target else { return nil }
            return handler(target, $0, $1, $2, $3)
        }
    }
}
