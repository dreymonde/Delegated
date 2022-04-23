//
//  Delegated.swift
//  Delegated
//
//  Created by Oleg Dreyman on 12/7/2020.
//  Copyright © 2020 Oleg Dreyman. All rights reserved.
//

public typealias Delegated = Delegated1
public typealias ReturningDelegated = ReturningDelegated1

@propertyWrapper
public final class Delegated1<Input> {
    
    public init() {
        self.callback = { _ in }
    }
    
    private var callback: (Input) -> Void
    
    public var wrappedValue: (Input) -> Void {
        return callback
    }
    
    public var projectedValue: Delegated1<Input> {
        return self
    }
}

public extension Delegated1 {
    func delegate<Target: AnyObject>(
        to target: Target,
        with callback: @escaping (Target, Input) -> Void
    ) {
        self.callback = { [weak target] input in
            guard let target = target else {
                return
            }
            return callback(target, input)
        }
    }
    
    func manuallyDelegate(with callback: @escaping (Input) -> Void) {
        self.callback = callback
    }
    
    func removeDelegate() {
        self.callback = { _ in }
    }
}

@propertyWrapper
public final class Delegated0 {
    
    public init() {
        self.callback = { }
    }
    
    private var callback: () -> Void
    
    public var wrappedValue: () -> Void {
        return callback
    }
    
    public var projectedValue: Delegated0 {
        return self
    }
}

public extension Delegated0 {
    func delegate<Target: AnyObject>(
        to target: Target,
        with callback: @escaping (Target) -> Void
    ) {
        self.callback = { [weak target] in
            guard let target = target else {
                return
            }
            return callback(target)
        }
    }
    
    func manuallyDelegate(with callback: @escaping () -> Void) {
        self.callback = callback
    }
    
    func removeDelegate() {
        self.callback = { }
    }
}

@propertyWrapper
public final class Delegated2<Input1, Input2> {
    
    public init() {
        self.callback = { _, _ in }
    }
    
    private var callback: (Input1, Input2) -> Void
    
    public var wrappedValue: (Input1, Input2) -> Void {
        return callback
    }
    
    public var projectedValue: Delegated2<Input1, Input2> {
        return self
    }
}

public extension Delegated2 {
    func delegate<Target: AnyObject>(
        to target: Target,
        with callback: @escaping (Target, Input1, Input2) -> Void
    ) {
        self.callback = { [weak target] (input1, input2) in
            guard let target = target else {
                return
            }
            return callback(target, input1, input2)
        }
    }
    
    func manuallyDelegate(with callback: @escaping (Input1, Input2) -> Void) {
        self.callback = callback
    }
    
    func removeDelegate() {
        self.callback = { _, _ in }
    }
}

@propertyWrapper
public final class Delegated3<Input1, Input2, Input3> {
    
    public init() {
        self.callback = { _, _, _ in }
    }
    
    private var callback: (Input1, Input2, Input3) -> Void
    
    public var wrappedValue: (Input1, Input2, Input3) -> Void {
        return callback
    }
    
    public var projectedValue: Delegated3<Input1, Input2, Input3> {
        return self
    }
}

public extension Delegated3 {
    func delegate<Target: AnyObject>(
        to target: Target,
        with callback: @escaping (Target, Input1, Input2, Input3) -> Void
    ) {
        self.callback = { [weak target] (input1, input2, input3) in
            guard let target = target else {
                return
            }
            return callback(target, input1, input2, input3)
        }
    }
    
    func manuallyDelegate(with callback: @escaping (Input1, Input2, Input3) -> Void) {
        self.callback = callback
    }
    
    func removeDelegate() {
        self.callback = { _, _, _ in }
    }
}

@propertyWrapper
public final class Delegated4<Input1, Input2, Input3, Input4> {
    
    public init() {
        self.callback = { _, _, _, _ in }
    }
    
    private var callback: (Input1, Input2, Input3, Input4) -> Void
    
    public var wrappedValue: (Input1, Input2, Input3, Input4) -> Void {
        return callback
    }
    
    public var projectedValue: Delegated4<Input1, Input2, Input3, Input4> {
        return self
    }
}

public extension Delegated4 {
    func delegate<Target: AnyObject>(
        to target: Target,
        with callback: @escaping (Target, Input1, Input2, Input3, Input4) -> Void
    ) {
        self.callback = { [weak target] (input1, input2, input3, input4) in
            guard let target = target else {
                return
            }
            return callback(target, input1, input2, input3, input4)
        }
    }
    
    func manuallyDelegate(with callback: @escaping (Input1, Input2, Input3, Input4) -> Void) {
        self.callback = callback
    }
    
    func removeDelegate() {
        self.callback = { _, _, _, _ in }
    }
}

@propertyWrapper
public final class ReturningDelegated1<Input, Output> {
    
    public init() {
        self.callback = { _ in return nil }
    }
    
    private var callback: (Input) -> Output?
    
    public var wrappedValue: (Input) -> Output? {
        return callback
    }
    
    public var projectedValue: ReturningDelegated1<Input, Output> {
        return self
    }
}

public extension ReturningDelegated1 {
    func delegate<Target: AnyObject>(
        to target: Target,
        with callback: @escaping (Target, Input) -> Output
    ) {
        self.callback = { [weak target] input in
            guard let target = target else {
                return nil
            }
            return callback(target, input)
        }
    }
    
    func manuallyDelegate(with callback: @escaping (Input) -> Output) {
        self.callback = callback
    }

    func removeDelegate() {
        self.callback = { _ in nil }
    }
}

@propertyWrapper
public final class ReturningDelegated0<Output> {
    
    public init() {
        self.callback = { return nil }
    }
    
    private var callback: () -> Output?
    
    public var wrappedValue: () -> Output? {
        return callback
    }
    
    public var projectedValue: ReturningDelegated0<Output> {
        return self
    }
}

public extension ReturningDelegated0 {
    func delegate<Target: AnyObject>(
        to target: Target,
        with callback: @escaping (Target) -> Output
    ) {
        self.callback = { [weak target] in
            guard let target = target else {
                return nil
            }
            return callback(target)
        }
    }
    
    func manuallyDelegate(with callback: @escaping () -> Output) {
        self.callback = callback
    }

    func removeDelegate() {
        self.callback = { nil }
    }
}

@propertyWrapper
public final class ReturningDelegated2<Input1, Input2, Output> {
    
    public init() {
        self.callback = { _, _ in return nil }
    }
    
    private var callback: (Input1, Input2) -> Output?
    
    public var wrappedValue: (Input1, Input2) -> Output? {
        return callback
    }
    
    public var projectedValue: ReturningDelegated2<Input1, Input2, Output> {
        return self
    }
}

public extension ReturningDelegated2 {
    func delegate<Target: AnyObject>(
        to target: Target,
        with callback: @escaping (Target, Input1, Input2) -> Output
    ) {
        self.callback = { [weak target] (input1, input2) in
            guard let target = target else {
                return nil
            }
            return callback(target, input1, input2)
        }
    }
    
    func manuallyDelegate(with callback: @escaping (Input1, Input2) -> Output) {
        self.callback = callback
    }

    func removeDelegate() {
        self.callback = { _, _ in nil }
    }
}

@propertyWrapper
public final class ReturningDelegated3<Input1, Input2, Input3, Output> {
    
    public init() {
        self.callback = { _, _, _ in return nil }
    }
    
    private var callback: (Input1, Input2, Input3) -> Output?
    
    public var wrappedValue: (Input1, Input2, Input3) -> Output? {
        return callback
    }
    
    public var projectedValue: ReturningDelegated3<Input1, Input2, Input3, Output> {
        return self
    }
}

public extension ReturningDelegated3 {
    func delegate<Target: AnyObject>(
        to target: Target,
        with callback: @escaping (Target, Input1, Input2, Input3) -> Output
    ) {
        self.callback = { [weak target] (input1, input2, input3) in
            guard let target = target else {
                return nil
            }
            return callback(target, input1, input2, input3)
        }
    }
    
    func manuallyDelegate(with callback: @escaping (Input1, Input2, Input3) -> Output) {
        self.callback = callback
    }

    func removeDelegate() {
        self.callback = { _, _, _ in nil }
    }
}

@propertyWrapper
public final class ReturningDelegated4<Input1, Input2, Input3, Input4, Output> {
    
    public init() {
        self.callback = { _, _, _, _ in return nil }
    }
    
    private var callback: (Input1, Input2, Input3, Input4) -> Output?
    
    public var wrappedValue: (Input1, Input2, Input3, Input4) -> Output? {
        return callback
    }
    
    public var projectedValue: ReturningDelegated4<Input1, Input2, Input3, Input4, Output> {
        return self
    }
}

public extension ReturningDelegated4 {
    func delegate<Target: AnyObject>(
        to target: Target,
        with callback: @escaping (Target, Input1, Input2, Input3, Input4) -> Output
    ) {
        self.callback = { [weak target] (input1, input2, input3, input4) in
            guard let target = target else {
                return nil
            }
            return callback(target, input1, input2, input3, input4)
        }
    }
    
    func manuallyDelegate(with callback: @escaping (Input1, Input2, Input3, Input4) -> Output) {
        self.callback = callback
    }

    func removeDelegate() {
        self.callback = { _, _, _, _ in nil }
    }
}

public extension Delegated0 {
    func pipe<Target: AnyObject>(via target: Target, to delegation: KeyPath<Target, Delegated0>) {
        self.delegate(to: target) { (target) in
           target[keyPath: delegation].wrappedValue()
        }
    }
}

public extension Delegated1 {
    func pipe<Target: AnyObject>(via target: Target, to delegation: KeyPath<Target, Delegated1<Target>>) {
        self.delegate(to: target) { (target, _) in
           target[keyPath: delegation].wrappedValue(target)
        }
    }
}

public extension Delegated2 {
    func pipe<Target: AnyObject>(via target: Target, to delegation: KeyPath<Target, Delegated2<Target, Input2>>) {
        self.delegate(to: target) { (target, _, input2) in
           target[keyPath: delegation].wrappedValue(target, input2)
        }
    }
}

public extension Delegated3 {
    func pipe<Target: AnyObject>(via target: Target, to delegation: KeyPath<Target, Delegated3<Target, Input2, Input3>>) {
        self.delegate(to: target) { (target, _, input2, input3) in
           target[keyPath: delegation].wrappedValue(target, input2, input3)
        }
    }
}

public extension Delegated4 {
    func pipe<Target: AnyObject>(via target: Target, to delegation: KeyPath<Target, Delegated4<Target, Input2, Input3, Input4>>) {
        self.delegate(to: target) { (target, _, input2, input3, input4) in
           target[keyPath: delegation].wrappedValue(target, input2, input3, input4)
        }
    }
}
