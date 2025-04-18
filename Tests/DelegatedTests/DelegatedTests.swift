import XCTest
import Foundation
@testable import Delegated

@available(watchOS 10.0.0, *)
@available(tvOS 17.0.0, *)
@available(iOS 17.0.0, *)
@available(macOS 14.0.0, *)
class A {
    @Delegated var didFinish: () -> ()
    
    func call() {
        print(#function)
        didFinish()
    }
}

@available(watchOS 10.0.0, *)
@available(tvOS 17.0.0, *)
@available(iOS 17.0.0, *)
@available(macOS 14.0.0, *)
final class DelegatedTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        
        let a = A()
        a.$didFinish.delegate(to: self) { (self) in
            self.hereYaGo()
        }
        
        a.call()
    }
    
    func testAll() {
        let tester = Tester()
        tester.setup()
        tester.perform()
    }
    
    func hereYaGo() {
        print(#function)
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}

struct Delegatedd<Input> {
    
    private(set) var callback: ((Input) -> Void)?
    
    mutating func delegate<Object : AnyObject>(
        to object: Object,
        with callback: @escaping (Object, Input) -> Void
    ){
        self.callback = { [weak object] input in
            guard let object = object else {
                return
            }
            callback(object, input)
        }
    }
    
}

final class Label {
    var text = ""
}


@available(watchOS 10.0.0, *)
@available(tvOS 17.0.0, *)
@available(iOS 17.0.0, *)
@available(macOS 14.0.0, *)
final class Button {
    @Delegated var didPress: () -> Void
}

@available(watchOS 10.0.0, *)
@available(tvOS 17.0.0, *)
@available(iOS 17.0.0, *)
@available(macOS 14.0.0, *)
final class Alert {
    @Delegated var didConfirm: () -> Void
    @Delegated var didCancel: () -> Void
    @ReturningDelegated var shouldReturn: (String) -> Bool?
    
    let confirmButton = Button()
    let cancelButton = Button()
    let textField = TextField()
    
    func didLoad() {
        confirmButton.$didPress.pipe(via: self, to: \.$didConfirm)
        cancelButton.$didPress.pipe(via: self, to: \.$didCancel)
        textField.$shouldReturn.pipe(via: self, through: \.$shouldReturn)
    }
}

@available(watchOS 10.0.0, *)
@available(tvOS 17.0.0, *)
@available(iOS 17.0.0, *)
@available(macOS 14.0.0, *)
final class ScrollView {
    @Delegated var didScrollTo: (_ x: CGFloat, _ y: CGFloat) -> Void
}


@available(watchOS 10.0.0, *)
@available(tvOS 17.0.0, *)
@available(iOS 17.0.0, *)
@available(macOS 14.0.0, *)
final class TextField {
    @ReturningDelegated  var shouldReturn: (String) -> Bool?
    
    @ReturningDelegated var shouldBeginEditing: () -> Bool?
    @ReturningDelegated var shouldReplace: (String, String) -> Bool?
    
    @Delegated var didUpdate: (String) -> Void
}

@available(watchOS 10.0.0, *)
@available(tvOS 17.0.0, *)
@available(iOS 17.0.0, *)
@available(macOS 14.0.0, *)
final class TestClass {
    @Delegated var zero: () -> Void
    @Delegated var one: (Int) -> Void
    @Delegated var def: (Int) -> Void
    @Delegated var two: (Int, String) -> Void
    @Delegated var three: (Int, String, Bool) -> Void
    @Delegated var four: (Int, String, Bool, Float) -> Void
    
    @ReturningDelegated var zeroOne: () -> Bool?
    @ReturningDelegated var oneOne: (Int) -> Bool?
    @ReturningDelegated var defOne: (Int) -> Bool?
    @ReturningDelegated var twoOne: (Int, String) -> Bool?
    @ReturningDelegated var threeOne: (Int, String, Bool) -> Bool?
    @ReturningDelegated var fourOne: (Int, String, Bool, Float) -> Bool?
}

@available(watchOS 10.0.0, *)
@available(tvOS 17.0.0, *)
@available(iOS 17.0.0, *)
@available(macOS 14.0.0, *)
final class Tester {
    
    let cls = TestClass()
    
    func returnSomething(values: Any...) -> Bool {
        print(#function, values)
        return Bool.random()
    }
    
    func doSomething(values: Any...) {
        print(#function, values)
    }
    
    func setup() {
        cls.$zero.delegate(to: self) { (self) in
            self.doSomething()
        }
        cls.$one.delegate(to: self) { (self, int) in
            self.doSomething(values: int)
        }
        cls.$def.delegate(to: self) { (self, int) in
            self.doSomething(values: int)
        }
        cls.$two.delegate(to: self) { (self, int, str) in
            self.doSomething(values: int, str)
        }
        cls.$three.delegate(to: self) { (self, int, str, bol) in
            self.doSomething(values: int, str, bol)
        }
        cls.$four.delegate(to: self) { (self, int, str, bol, flt) in
            self.doSomething(values: int, str, bol, flt)
        }
        
        cls.$zeroOne.delegate(to: self) { (self) in
            return self.returnSomething()
        }
        cls.$oneOne.delegate(to: self) { (self, int) in
            return self.returnSomething(values: int)
        }
        cls.$defOne.delegate(to: self) { (self, int) in
            return self.returnSomething(values: int)
        }
        cls.$twoOne.delegate(to: self) { (self, int, str) in
            return self.returnSomething(values: int, str)
        }
        cls.$threeOne.delegate(to: self) { (self, int, str, bol) in
            return self.returnSomething(values: int, str, bol)
        }
        cls.$fourOne.delegate(to: self) { (self, int, str, bol, flt) in
            return self.returnSomething(values: int, str, bol, flt)
        }
    }
    
    func perform() {
        cls.zero()
        cls.one(1)
        cls.def(11)
        cls.two(2, "2")
        cls.three(3, "3", true)
        cls.four(4, "4", true, 4.0)
        
        print(cls.zeroOne()!)
        print(cls.oneOne(1)!)
        print(cls.defOne(11)!)
        print(cls.twoOne(2, "2")!)
        print(cls.threeOne(3, "3", true)!)
        print(cls.fourOne(4, "4", true, 4.0)!)
    }
}

@available(watchOS 10.0.0, *)
@available(tvOS 17.0.0, *)
@available(iOS 17.0.0, *)
@available(macOS 14.0.0, *)
final class ViewController {
    
    let textField = TextField()
    let label = Label()
    
    func viewDidLoad() {
        
textField.$shouldReturn.delegate(to: self) { (self, string) -> Bool in
    if string.count > 5 {
        return true
    } else {
        return false
    }
}
        
        textField.$didUpdate.delegate(to: self) { (self, text) in
            self.label.text = text
        }
        
        textField.$shouldReturn.delegate(to: self) { (self, str) -> Bool in
            if str == "A" {
                return true
            } else {
                return false
            }
        }
    }
}
