//
//  DelegatedTests.swift
//  Delegated
//
//  Created by Oleg Dreyman on 3/11/18.
//  Copyright © 2018 Delegated. All rights reserved.
//

import XCTest
@testable import Delegated

class DelegatedTests: XCTestCase {
    
    func testExample() {
        class Example {
            var stringForIndexPath = Delegated<IndexPath, String>()
            func printString(for indexPath: IndexPath) {
                if let string = stringForIndexPath.call(indexPath) {
                    print(string)
                }
            }
        }
        
        class Controller {
            let printer = Example()
            init() {
                self.printer.stringForIndexPath.delegate(to: self) { (self, indexPath) -> String in
                    return self.string(for: indexPath)
                }
            }
            var onDeinit: () -> () = { }
            deinit {
                onDeinit()
            }
            func string(for indexPath: IndexPath) -> String {
                return String.init(describing: indexPath)
            }
        }
        
        var controller: Controller? = Controller()
        var wasDeallocated = false
        controller!.onDeinit = { wasDeallocated = true }
        controller!.printer.printString(for: IndexPath.init(item: 1, section: 1))
        controller = nil
        XCTAssertTrue(wasDeallocated)
    }
    
    func testVoidOutput() {
        
        class Example {
            var printNumber = Delegated<Int, Void>()
            func perform(on number: Int) {
                let multiplied = number * 2
                printNumber.call(multiplied)
            }
        }
        
        class Controller {
            let example = Example()
            init() {
                example.printNumber.delegate(to: self) { (self, number) in
                    self.printNumber(number)
                }
            }
            func printNumber(_ number: Int) {
                print(number)
            }
            var onDeinit: () -> () = { }
            deinit {
                onDeinit()
            }
        }
        
        class StrongController {
            let example = Example()
            init() {
                example.printNumber.stronglyDelegate(to: self) { (self, number) in
                    self.printNumber(number)
                }
            }
            func printNumber(_ number: Int) {
                print(number)
            }
            var onDeinit: () -> () = { }
            deinit {
                onDeinit()
            }
        }
        
        var controller: Controller? = Controller()
        var wasDeallocated = false
        controller!.onDeinit = { wasDeallocated = true }
        controller!.example.perform(on: 10)
        controller = nil
        XCTAssertTrue(wasDeallocated)
        
        var strong: StrongController? = StrongController()
        wasDeallocated = false
        strong!.onDeinit = { wasDeallocated = true }
        strong!.example.perform(on: 15)
        strong = nil
        XCTAssertFalse(wasDeallocated)
        
    }
    
    static var allTests = [
        ("testExample", testExample),
    ]
    
}

